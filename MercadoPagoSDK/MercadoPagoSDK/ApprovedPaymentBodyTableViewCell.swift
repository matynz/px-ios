//
//  ApprovedPaymentBodyTableViewCell.swift
//  MercadoPagoSDK
//
//  Created by Maria cristina rodriguez on 9/5/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

import UIKit

class ApprovedPaymentBodyTableViewCell: CallbackCancelTableViewCell, CongratsFillmentDelegate {
    
    @IBOutlet weak var creditCardIcon: UIImageView!
    
    @IBOutlet weak var creditCardLabel: MPLabel!
    @IBOutlet weak var amountDescription: UILabel!
    @IBOutlet weak var subtitle: MPLabel!
    
    @IBOutlet weak var voucherId: MPLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let overLinewView = UIView(frame: CGRect(x: 0, y: 140, width: self.bounds.width, height: 1))
        overLinewView.backgroundColor = UIColor.UIColorFromRGB(0xDEDEDE)
        self.addSubview(overLinewView)

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.subtitle.addLineSpacing(6, centered: false)
    }
    
    func fillCell(payment: Payment, paymentMethod : PaymentMethod, callback : (Void -> Void)?) -> UITableViewCell {

        self.voucherId.text = "Comprobante".localized + " " + String(payment._id)
        let greenLabelColor = UIColor(red: 67, green: 176,blue: 0)
        
        let cardLastFourDigits = (payment.card != nil && payment.card.lastFourDigits != nil && payment.card.lastFourDigits!.isNotEmpty) ? "terminada en " + payment.card.lastFourDigits! : ""
        self.creditCardLabel.text = cardLastFourDigits
        
        let paymentMethodIcon = MercadoPago.getImage(payment.paymentMethodId)
        if paymentMethodIcon != nil {
            self.creditCardIcon.image = MercadoPago.getImage(payment.paymentMethodId)
            if paymentMethod.paymentTypeId == PaymentTypeId.ACCOUNT_MONEY.rawValue {
                self.creditCardLabel.text = "Dinero en cuenta de Mercado Pago".localized
            }
        } else {
            self.creditCardIcon.hidden = true
            self.creditCardLabel.text = ""
        }
        
        
        let additionalTextAttributes = [NSForegroundColorAttributeName : greenLabelColor, NSFontAttributeName : UIFont(name:MercadoPago.DEFAULT_FONT_NAME, size: 14)!]
        let noRateTextAttributes = [NSForegroundColorAttributeName : greenLabelColor, NSFontAttributeName : UIFont(name:MercadoPago.DEFAULT_FONT_NAME, size: 14)!]
        let additionalString = NSMutableAttributedString(string: " ")
        
        if payment.feesDetails != nil && payment.feesDetails.count > 0 {
            let financingFee = payment.feesDetails.filter({ return $0.isFinancingFeeType()})
            if financingFee.count > 0 {
                let currency = MercadoPagoContext.getCurrency()
                if payment.transactionDetails != nil && payment.transactionDetails.totalPaidAmount > 0 && payment.installments > 0 {
                    additionalString.appendAttributedString(NSAttributedString(string : "( ", attributes: additionalTextAttributes))
                    additionalString.appendAttributedString(Utils.getAttributedAmount(payment.transactionDetails.totalPaidAmount, thousandSeparator: String(currency.thousandsSeparator), decimalSeparator: String(currency.decimalSeparator), currencySymbol:currency.symbol, color: greenLabelColor, fontSize : 14, baselineOffset: 3))
                    additionalString.appendAttributedString(NSAttributedString(string : " )", attributes: additionalTextAttributes))
                } else {
                    self.amountDescription.hidden = true
                }
            } else {
                if payment.installments != 1 {
                    additionalString.appendAttributedString(NSAttributedString(string: "Sin interés".localized, attributes : noRateTextAttributes))
                }
            }
        } else if payment.installments > 1 {
                additionalString.appendAttributedString(NSAttributedString(string: "Sin interés".localized, attributes : noRateTextAttributes))
        }
        
        if payment.transactionDetails != nil && payment.transactionDetails.installmentAmount > 0 {
            self.amountDescription.attributedText = Utils.getTransactionInstallmentsDescription(String(payment.installments), installmentAmount: payment.transactionDetails.installmentAmount, additionalString: additionalString)
        } else {
            self.amountDescription.hidden = true
        }
        
        return self
    }
    
    func getCellHeight(payment: Payment, paymentMethod: PaymentMethod) -> CGFloat {
        return 206
    }
    
}
