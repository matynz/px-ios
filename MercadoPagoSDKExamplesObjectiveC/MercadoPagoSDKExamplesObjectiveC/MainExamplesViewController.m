//
//  MainExamplesViewController.m
//  MercadoPagoSDKExamplesObjectiveC
//
//  Created by Maria cristina rodriguez on 1/7/16.
//  Copyright © 2016 MercadoPago. All rights reserved.
//

#import "MainExamplesViewController.h"
#import "ExampleUtils.h"
#import "CustomTableViewCell.h"
#import "PendingTableViewCell.h"
#import "SubeTableViewCell.h"
#import "DineroEnCuentaTableViewCell.h"

@import MercadoPagoSDK;


@implementation MainExamplesViewController



- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)checkoutFlow:(id)sender {

    // Decoration Preference con colores custom
    DecorationPreference *decorationPreference = [[DecorationPreference alloc] initWithBaseColor:[UIColor greenColor] fontName:@"fontName"];
    [MercadoPagoCheckout setDecorationPreference:decorationPreference];
    
    // Service Preference para seteo de servicio de pago
    NSDictionary *extraParams = @{
                                  @"merchant_access_token" : @"mla-cards-data"
                                  };
    ServicePreference * servicePreference = [[ServicePreference alloc] init];
    
    
    //[servicePreference setCreatePaymentWithBaseURL:@"https://private-0d59c-mercadopagoexamples.apiary-mock.com" URI:@"/create_payment" additionalInfo:extraParams];
    
    [MercadoPagoCheckout setServicePreference:servicePreference];
    
    [MercadoPagoContext setLanguageWithLanguage:"es"];
    
    
    
  //  [servicePreference setGetCustomerWithBaseURL:@"https://www.mercadopago.com" URI:@"/checkout/examples/getCustomer" additionalInfo:extraParams];
    
    Item *item = [[Item alloc] initWith_id:@"itemId" title:@"item title" quantity:100 unitPrice:10 description:nil currencyId:@"ARS"];
    Item *item2 = [[Item alloc] initWith_id:@"itemId2" title:@"item title 2" quantity:2 unitPrice:2 description:@"item description" currencyId:@"ARS"];
    Payer *payer = [[Payer alloc] initWith_id:@"payerId" email:@"payer@email.com" type:nil identification:nil];
    
    NSArray *items = [NSArray arrayWithObjects:item2, item2, nil];
    
    PaymentPreference *paymentExclusions = [[PaymentPreference alloc] init];
    paymentExclusions.excludedPaymentTypeIds = [NSSet setWithObjects:@"atm", @"ticket", nil];
    //CheckoutPreference * pref = [[CheckoutPreference alloc] initWithItems:items payer:payer paymentMethods:paymentExclusions];
    
    
    //CheckoutPreference * pref = [[CheckoutPreference alloc] initWithItems:<#(NSArray<Item *> * _Nonnull)#> payer:<#(Payer * _Nonnull)#> paymentMethods:<#(PaymentPreference * _Nullable)#>
    
    CustomTableViewCell *cargaSubeCell = [[[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:self options:nil] firstObject];
    cargaSubeCell.label.text = @"Carga SUBE";
    [cargaSubeCell.button setTitle:@"Cambiar" forState:UIControlStateNormal];
    [cargaSubeCell.button addTarget:self action:@selector(invokeCallback:) forControlEvents:UIControlEventTouchUpInside];
    MPCustomCell *customCargaSube = [[MPCustomCell alloc] initWithCell:cargaSubeCell];
    self.customCell = customCargaSube;

    
    ReviewScreenPreference *reviewPreference = [[ReviewScreenPreference alloc] init];
    [reviewPreference setTitleWithTitle:@"Recarga tu SUBE"];
    [reviewPreference setProductsDeteailWithProductsTitle:@"Carga SUBE"];
    [reviewPreference setConfirmButtonTextWithConfirmButtonText:@"Confirmar recarga"];
    [reviewPreference setCancelButtonTextWithCancelButtonText:@"Cancelar recarga"];
    [ReviewScreenPreference addCustomItemCellWithCustomCell:customCargaSube];
    //[ReviewScreenPreference addAddionalInfoCellWithCustomCell:customCargaSube];
//
    [MercadoPagoCheckout setReviewScreenPreference:reviewPreference];
    
    
    PendingTableViewCell *cargaSubeCellCongrats = [[[NSBundle mainBundle] loadNibNamed:@"PendingTableViewCell" owner:self options:nil] firstObject];
    cargaSubeCellCongrats.label.text = @"Para acreditar tu recarga";
    MPCustomCell *customCargaSubeCongrats = [[MPCustomCell alloc] initWithCell:cargaSubeCellCongrats];
    
    SubeTableViewCell *subeCell = [[[NSBundle mainBundle] loadNibNamed:@"SubeTableViewCell" owner:self options:nil] firstObject];
    MPCustomCell *subeCongrats = [[MPCustomCell alloc] initWithCell:subeCell];

    DineroEnCuentaTableViewCell *dineroEnCuenta = [[[NSBundle mainBundle] loadNibNamed:@"DineroEnCuentaTableViewCell" owner:self options:nil] firstObject];
    [dineroEnCuenta.button addTarget:self action:@selector(invokeCallbackPaymentResult:) forControlEvents:UIControlEventTouchUpInside];
    MPCustomCell *dineroEnCuentaCustom = [[MPCustomCell alloc] initWithCell:dineroEnCuenta];
    self.dineroEnCuentaCell = dineroEnCuentaCustom;
    PaymentResultScreenPreference *resultPreference = [[PaymentResultScreenPreference alloc]init];
    [resultPreference setPendingTitleWithTitle:@"¡Pagaste la recarga de SUBE de $50!"];
    [resultPreference setExitButtonTitleWithTitle:@"Ir a Actividad"];
    [resultPreference disableChangePaymentMethodOption];
    [resultPreference setPendingHeaderIconWithName:@"iconoPagoOffline" bundle:[NSBundle mainBundle]];
    [resultPreference setAppovedTitleWithTitle:@"¡Listo, recargaste el celular"];
    
    
    [PaymentResultScreenPreference addCustomPendingCellWithCustomCell:customCargaSubeCongrats];
    [PaymentResultScreenPreference addCustomPendingCellWithCustomCell:subeCongrats];
    [PaymentResultScreenPreference addCustomApprovedCellWithCustomCell:dineroEnCuentaCustom];
    [MercadoPagoCheckout setPaymentResultScreenPreference:resultPreference];
    
    
//
    /*[MercadoPagoCheckout setPaymentDataCallbackWithPaymentDataCallback: ^(PaymentData *paymentData) {
        NSLog(@"%@", paymentData.paymentMethod._id);
        NSLog(@"%@", paymentData.token._id);
        NSLog(@"%ld", paymentData.payerCost.installments);
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];*/
    
    [MercadoPagoContext setLanguageWithLanguage:"es"];
    
    CheckoutPreference * pref = [[CheckoutPreference alloc] initWith_id: @"150216849-68645cbb-dfe6-4410-bfd6-6e5aa33d8a33"];
    [[[MercadoPagoCheckout alloc] initWithCheckoutPreference:pref navigationController:self.navigationController] start] ;

    PaymentMethod *pm = [[PaymentMethod alloc] init];
    pm._id = @"visa";
    pm.paymentTypeId = @"credit_card";
    pm.name = @"visa";
    
    
    PaymentData *pd = [[PaymentData alloc] init];
    pd.paymentMethod = pm;
    
    pd.token = [[Token alloc] initWith_id:@"id" publicKey:@"pk" cardId:@"card" luhnValidation:nil status:nil usedDate:nil cardNumberLength:nil creationDate:nil lastFourDigits:nil firstSixDigit:@"123456" securityCodeLength:3 expirationMonth:11 expirationYear:2012 lastModifiedDate:nil dueDate:nil cardHolder:nil];
    pd.token.lastFourDigits = @"7890";
    pd.payerCost = [[PayerCost alloc] initWithInstallments:3 installmentRate:10 labels:nil minAllowedAmount:10 maxAllowedAmount:200 recommendedMessage:@"sarsa" installmentAmount:100 totalAmount:200];
    //[[[MercadoPagoCheckout alloc] initWithCheckoutPreference:pref paymentData:pd navigationController:self.navigationController] start];
    //[[MercadoPagoCheckout alloc] initWithCheckoutPrefence:<#(CheckoutPreference * _Nonnull)#> navigationController:<#(UINavigationController * _Nonnull)#>
    //[servicePreference setCreatePaymentWithBaseURL:@"baseUrl" URI:@"paymentUri" additionalInfo:extraParams];
   // [MercadoPagoCheckout setServicePreference:servicePreference];
    
}

-(void)invokeCallback:(MPCustomCell *)button {
    
    [[self.customCell getDelegate] invokeCallbackWithPaymentDataWithRowCallback:^(PaymentData *paymentData) {
        NSLog(@"%@", paymentData.paymentMethod._id);
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}

-(void)invokeCallbackPaymentResult:(MPCustomCell *)button {
    
    [[self.dineroEnCuentaCell getDelegate] invokeCallbackWithPaymentResultWithRowCallback:^(PaymentResult *paymentResult) {
        NSLog(@"%@", paymentResult.status);
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}

@end
