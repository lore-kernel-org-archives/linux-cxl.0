Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348BBC433EF
	for <linux-cxl@archiver.kernel.org>; Wed, 18 May 2022 02:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiERCHu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 17 May 2022 22:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234104AbiERCHt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 17 May 2022 22:07:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A4753B58
        for <linux-cxl@vger.kernel.org>; Tue, 17 May 2022 19:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652839667; x=1684375667;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8OjKmpPr4gVoQvyfMc7VwbrkVVPvpUWtz+1RRpoY5TA=;
  b=za70fy4bqXtlSHBtvTXLTLH56DloZ1InQuTxFPuOTq4Wi78X1jXjVnNY
   GkgW6yl3MjihzEgAebOvgbzel8MwB1G+1LxgPJIYHH/UjDuR3mx/sUhFQ
   W3zOdaLCgHFhH5lQhCNWe6Y/FEJsA/8HT8/O9x6SYr6MaHAAK+439mwWA
   R8MvXUQfSuv/h6bilSw06CcX2xoTxycD6bwItoVPZgvtwCcAV5HgHJgZh
   BwGB4zzE6+iQDD7aZbQaTfM9qrzaM5KxOy9CY/WFb2+yZETsVWbveqovA
   q5fG4Y/XhOAoC1pca+EoWoapD7PXqRmBGvoLB3MUs2gtTt9VY0TvCwCaY
   A==;
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="173856318"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 May 2022 19:07:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 17 May 2022 19:07:46 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 17 May 2022 19:07:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GjddtO/+ILj6Kckv6UDBoJGIwzSfTmZ7k87HejoBQ2eyJS21y10YSZ3s2nt41VMpmk9Jezo8Dw23sXb0ZYz2/a2WHXS7PMVpAaxNMhBztqiIa4X9ib5dTlsFjbxsae9yEN0+tcBmeh0tqy+luuc4ZgCJmoWvcH+fIHYycyr6yeisrXOm6AQWO4EWDMXE+mOUPWnGvDC41UVOO1AsO86Lg9FpTsAFj8G0G45hC/ZSRiZ6O9pSexOMMOTRE9jiNO6FIVj4PoNEJRKOavnselDyhj0KmTw1bn1x/Scj5yXnA2BWnpshS+G8HA75QxvPC4JyLfF0BVdKSaI5UZxupV7M9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OjKmpPr4gVoQvyfMc7VwbrkVVPvpUWtz+1RRpoY5TA=;
 b=XnE7Xmh8K/LDlk3LGrRUI4GBtHkXGXKd3shxPi1oliWXKsTB8K/vKJre8Z2tLn1C+ZNnH5zFbViBaDcBmuF7Ad0QlwBWE6kGTt4FmbpyAPDkd/YFQ0DVNaKRNNXw98sK/sAwfsRNnDQrmU/yVLgFFYehaS5bYC7+fOyutSBL9pe4aZbkuE7r7R9gidXRgyXqI4TyzLthMs7cVgh7IbLZ05NzCtIv5zaVD+iMnW4hkMf1PYl5WZbiYEX4odhvni7tscoGDVfkLfBzDf8nIsHkYInbkv1SHZWbnjXEhbLHrhTlu/4+eoDvG7sDKkdl2KeZVQdK6s5S6qUjhjiX8i2hSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OjKmpPr4gVoQvyfMc7VwbrkVVPvpUWtz+1RRpoY5TA=;
 b=KN7kKBRpMBOiiX5DAxdmebKSBVt25OEiJmkccXzmv8AdVdjbeu/QKz3cJhqFMN4uJgGcilTE/kLA80PzEzt+txp+1Iz7V7cD7stZG86qFsKfbB3e34rJN0qjoDCOlL51kKlWRWgrjdiuobvyfQHEKsr0T1ZySzzwhDezB3gt0/I=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (2603:10b6:208:f8::13)
 by CY4PR11MB1286.namprd11.prod.outlook.com (2603:10b6:903:2e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Wed, 18 May
 2022 02:07:41 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::4d82:9b1a:3a79:df20]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::4d82:9b1a:3a79:df20%3]) with mapi id 15.20.5250.018; Wed, 18 May 2022
 02:07:40 +0000
From:   <Ariel.Sibley@microchip.com>
To:     <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.carpenter@oracle.com>, <Jonathan.Cameron@huawei.com>,
        <ira.weiny@intel.com>
Subject: RE: [PATCH v2 14/14] cxl/port: Enable HDM Capability after validating
 DVSEC Ranges
Thread-Topic: [PATCH v2 14/14] cxl/port: Enable HDM Capability after
 validating DVSEC Ranges
Thread-Index: AQHYak+VqC+01bgxVEuyclncvk+HFq0j0eaQ
Date:   Wed, 18 May 2022 02:07:40 +0000
Message-ID: <MN2PR11MB3645021EB1CC6D28206D75AD88D19@MN2PR11MB3645.namprd11.prod.outlook.com>
References: <165237933127.3832067.12500546479146655886.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165283418817.1033989.11273676872054815459.stgit@dwillia2-xfh>
In-Reply-To: <165283418817.1033989.11273676872054815459.stgit@dwillia2-xfh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8db8cba9-6e72-4a2d-4fe8-08da3873304e
x-ms-traffictypediagnostic: CY4PR11MB1286:EE_
x-microsoft-antispam-prvs: <CY4PR11MB1286A329649721300027A19788D19@CY4PR11MB1286.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OuT75H3/jEKnKTusnf8p6IiQQdWHRMuolJDZsTvbNig9sZvhs0VhbnEuYlLAUnpHViy2oUPcOyCQXkovmTXn55BHwsck4e3n2UHpt+CvNnYQMh5Lint3XTNV6opjoCPlaU/NkKKChlaqqpy9QaABsva32FbEPtO6zzGLzfIl3a8EkSN8rVosXPfYo0mdBUeYerHiNIMDMxvE7DkTPYD2/lTHAN2z017ISE+bxVo/ddB2XY2ZSZJ0g19/ow82YZQU8V9XrBVRrBT3uj5mnMq5rJ9u56yUtDHFZ6fU7Jtng2sxjaUUFZv19onABua9jAf8YlD8C8IrPzBFg/7AqU0Iap/7COaSbFfh6clT+tLxe/SoWbmeiPp3BOGcTrMxBO1gnGxOa2TpEfXYNx/Wu9CHg76fP6z50Vjx3Ol0Ge8Rn0+5aWj+px9uyjlmvi6wKM1QcZTsccOewCdhlN+fCW180q0BizG40mX21SuqGTNvAkTjaERwm/nR6m2nbIfPnaBlg1idlb4M5PtqvGSFRHWt+/BOQE/tN3Dxla2P8enVvykLB7efWuAjZOGKK0PFGr7N31zOV7MdZl+CzWcUrV67BWVBzK6bxcORVkjmHtoMwBJ50Vfi79CjF1MHY8mEsGeE1F0Qp2nVkzvxR1CxTGuc63SSAoU3SIXHEILGJQFE5gbZn+GQsFg69VvDDY8pDi5a+LY1SNvzICpwi6xhJ7fx8g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(38070700005)(38100700002)(316002)(55016003)(83380400001)(186003)(76116006)(52536014)(110136005)(122000001)(8676002)(9686003)(33656002)(8936002)(7696005)(2906002)(508600001)(6506007)(54906003)(66446008)(66946007)(64756008)(66556008)(66476007)(4326008)(86362001)(26005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3cvSjM1MFZBVlNqZGpDZklUL1hlSTc0UXIrWWV2MXBaQkJqMkJuN29weDZq?=
 =?utf-8?B?THVIVDA3R1QwWXFSTnBBVm5jNnhaQzlRbGdmUmdoaWJ2Nm5ZTzdsaTFydnpy?=
 =?utf-8?B?bmtzaktBWW9PaU1BT0ZJODJqWGNWRklpOG9kYU02YlBPa2x5MXlDckdRMnY4?=
 =?utf-8?B?N1hMQno3MjdSTFpDSk9yRURFcFZEMmZja2ZqVUNlSEdzUWZrQmtCakRzSEN4?=
 =?utf-8?B?bWRja0dYVFdsY2NzYjA1eVhzZE16T21yNmEwMU4zVUE1YjFDMWRLTkRVZG5t?=
 =?utf-8?B?NVpOQ3hDazhocEc3RGF5cDgrblg4RmQ3YXVyYmN5WDMrSGJJT1duQVpDVXk2?=
 =?utf-8?B?YU9yaDlqREVqdVd0SXJQWFk0VmJpK3FyY0VJR3RuSEViV0M4bWpxL2JuZHQv?=
 =?utf-8?B?UzFHWGpUNzBzNDI0SVEzLzUvOXdaNnVqUG5OU0c3R2VLUnY0akNyc1RIbXdr?=
 =?utf-8?B?V2l4a0ZXbVF0bWF6ZTYwUWp1WDdxNDhuUDBRWldYUm1IMmE4QTJRQ1JXcHdx?=
 =?utf-8?B?WFV2TDN1bERpUWg3SVQ3N0RVRXo0QjVqclF1T2dYQ1pnclNnV0ZQRmpLR0hr?=
 =?utf-8?B?SXQ2NStwcFNWYVpKbnZUU3BFVjZqTTlHd1RXMzA1dWMvTVFVYXlHSUk5RzhO?=
 =?utf-8?B?RTR1a0xjSzhWTXdRVVlpMXZuS3lZWTBnRzVJdnVQaU14MmN5SjFSdVJxY21C?=
 =?utf-8?B?Q2RNVUV0LzU4SzU0dkhrUXhuNEhSdnloNS8yaVRMOE1xTTlQZ2luZlV3QUVq?=
 =?utf-8?B?eGRReWhLRzc1RjR0aEJFclBuMXBZRGY0QTVLc1h3RFhDTFlyQ1ZwbTkvNTJk?=
 =?utf-8?B?Z2JoYmNjaTQwc2lBZXVpcHlNdXplbVlSaG9VUTc5OU8xdHhMQTZsTU84SlJm?=
 =?utf-8?B?bldpTUE0amJRTXlUM295N1pOZXpLOFM4Uy9BZTl6WjNsOFVvbnZpU1N1R0Rz?=
 =?utf-8?B?N2ZrN2wyWHFXMGZhY1JQdlpwRGNXbWxmM2JxMmRxWWRKQllFYktsclJsVGRt?=
 =?utf-8?B?THB4YTVJQVh3YUFsY0VjdXQ0ZVVIR2ZPU0VJY3B0Zk1Ndml5eVdmZUtFK1Nj?=
 =?utf-8?B?ZEhqNWhzcGFueW9qS0ROdnBlcC9JbkZEcmxPOENDRkZFbUdGK3p4SXBoTVNC?=
 =?utf-8?B?RHcrcTdDYzh6T0NhZDV1NnI0VGlMZktFZ3NTdFF2NnFIeFh0Q2krQmJkcFBk?=
 =?utf-8?B?OEplNlV3RVY5QTVFK1FhR1o2T1pDZ2V0VE1SK01lenEvZmV2VGZRMThvay9D?=
 =?utf-8?B?RGRGWmtNWDdnZlZ0UVJ5VlI4cUNoWFE4cnRheksyRExJRkFuUVlPU1lOclVU?=
 =?utf-8?B?MnNTQTNrSituTjQxY0EvU1FzU2JqZy94Y0M3NWUvYTNEcFQrNVJGUHZNa0Vn?=
 =?utf-8?B?cHZvOEZWREIyMmduSTM0MVk3KzdHOWtSbzZDaS8yNXp0RnhJU1U5VGk4L1VX?=
 =?utf-8?B?K1JIbjFEcVkvdEFnWVg1QVpEL0tsMUZxREhGWnFDZDRES1gwN3BhRERtaW9U?=
 =?utf-8?B?OURXWEJ3dFRFakFHeS93cm9PWWdOR3hwcldwZDFySUlzSHgveFlVUXFTQzJm?=
 =?utf-8?B?Wnp4Q1pXNktjWWo3OC9RS0ozeDNUcWJkZnlPQWdjVkxCUUU3NS9YNXBGSUgr?=
 =?utf-8?B?cDZURGJaTVZkK1E3VkFKYmlPdWR4d1B1K1ZpdVZUemd4QlpOV0NEanFjOEI5?=
 =?utf-8?B?OVhrMkxqSUw0T1E2UWFLVVRTenZMc1F5VzZEOWgycXVCclJFZHRtSkpLMUo4?=
 =?utf-8?B?eVZNT2hnUndOVTJrakcrbElUbC9hZE4yNE9obHhHdXNaajFDNldEdW9hVmRL?=
 =?utf-8?B?UlV5OTQwYWhMWkVXMkp4T05TcmFDQ0RZMFdQTFNOYytVemFWR0pqNVhYS0U3?=
 =?utf-8?B?aGI4WjlOKzlJRzV6d2JSM0txSWtKelV5b2hyamNOVVg1U0FwaTRkOEY2U0NG?=
 =?utf-8?B?a25mbnBmRS9tNm44ZGRtemNiNlFVNGpiMmpiTjhjQndiZHNia015aVY3TWNu?=
 =?utf-8?B?MlVlNUk4RGN6NU5Qb2NYVGJYeWhJNVFkR1hlRTEwWUo1cWtxek02dER4SzVs?=
 =?utf-8?B?enMrbmFORS9UREI3Nm8vMTVNVzl0dzFGbmFRZkRFMmgvOWFQaWNaT2lpOWF6?=
 =?utf-8?B?YnZRY1NQa09mUGdBc1BEbFpUNnEvcDYzUzBzVkZUMEZmVWFkWmt2SnhkbVly?=
 =?utf-8?B?d25sMnBiMkdTNmttNHJBNTV3Z055R25CTExVc2J3OGZrdXFYeUhIMWxickE5?=
 =?utf-8?B?c2NEQU5CNUtwdEtxR083QUM4TGt3Tkg3SjIrN0FUNDJHR1VJMFdiQ0QvOWF2?=
 =?utf-8?B?K3B0V3duVjRMMDI2czhSVEtiTFhaczRDQmVFTmxJcnVySXBRTVVodz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8db8cba9-6e72-4a2d-4fe8-08da3873304e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2022 02:07:40.8867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3mGPyeYj3cwS8XmgjOun8CUVH3J/YyaO5VqzZbWb130nAMr/+zaMvhBURBfvzmoUb/VCLx3/b59L3LSykut1Ew6wg1F5HDR/KM+NlMJA290=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1286
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

PiBQcmV2aW91c2x5LCB0aGUgY3hsX21lbSBkcml2ZXIgd2FzIHJlbHlpbmcgb24gcGxhdGZvcm0t
ZmlybXdhcmUgdG8gc2V0DQo+ICJtZW1fZW5hYmxlIi4gVGhhdCBpcyBhbiBpbnZhbGlkIGFzc3Vt
cHRpb24gYXMgdGhlcmUgaXMgbm8gcmVxdWlyZW1lbnQNCj4gdGhhdCBwbGF0Zm9ybS1maXJtd2Fy
ZSBzZXRzIHRoZSBiaXQgYmVmb3JlIHRoZSBkcml2ZXIgc2VlcyBhIGRldmljZSwNCj4gZXNwZWNp
YWxseSBpbiBob3QtcGx1ZyBzY2VuYXJpb3MuIEFkZGl0aW9uYWxseSwgQUNQSS1wbGF0Zm9ybXMg
dGhhdA0KPiBzdXBwb3J0IENYTCAyLjAgZGV2aWNlcyBhbHNvIHN1cHBvcnQgdGhlIEFDUEkgQ0VE
VCAoQ1hMIEVhcmx5IERpc2NvdmVyeQ0KPiBUYWJsZSkuIFRoYXQgdGFibGUgb3V0bGluZXMgdGhl
IHBsYXRmb3JtIHBlcm1pc3NpYmxlIGFkZHJlc3MgcmFuZ2VzIGZvcg0KPiBDWEwgb3BlcmF0aW9u
LiBTbywgdGhlcmUgaXMgYSBuZWVkIGZvciB0aGUgZHJpdmVyIHRvIHNldCAibWVtX2VuYWJsZSIs
DQo+IGFuZCB0aGVyZSBpcyBpbmZvcm1hdGlvbiBhdmFpbGFibGUgdG8gZGV0ZXJtaW5lIHRoZSB2
YWxpZGl0eSBvZiB0aGUgQ1hMDQo+IERWU0VDIFJhbmdlcy4gV2hpbGUgRFZTRUMgUmFuZ2VzIGFy
ZSBleHBlY3RlZCB0byBiZSBhdCBsZWFzdA0KPiAyNTZNIGluIHNpemUsIHRoZSBzcGVjaWZpY2F0
aW9uIChDWEwgMi4wIFNlY3Rpb24gOC4xLjMuOC40IERWU0VDIENYTA0KPiBSYW5nZSAxIEJhc2Ug
TG93KSBhbGxvd3MgZm9yIHRoZSBwb3NzaWJpbHR5IG9mIGRldmljZXMgc21hbGxlciB0aGFuDQo+
IDI1Nk0uIFNvIHRoZSByYW5nZSBbMCwgMjU2TSkgaXMgY29uc2lkZXJlZCBhY3RpdmUgZXZlbiBp
ZiBNZW1vcnlfc2l6ZQ0KPiBpcyAwLg0KDQpSZWdhcmRpbmcgIlNvIHRoZSByYW5nZSBbMCwgMjU2
TSkgaXMgY29uc2lkZXJlZCBhY3RpdmUgZXZlbiBpZg0KTWVtb3J5X3NpemUgaXMgMC4iDQoNClNp
bmNlIE1lbW9yeV9CYXNlIGlzIGluY2x1ZGVkIGluIGFkZHJlc3MgQSwgdGhpcyBwb3J0aW9uIG9m
IHRoZSBlcXVhdGlvbg0KZnJvbSBDWEwgMi4wIFNlY3Rpb24gOC4xLjMuOC40IG1hbmRhdGVzIHRo
YXQgZm9yIGhvc3QgYWNjZXNzIHRvIGFkZHJlc3MgQQ0KdG8gYmUgZGlyZWN0ZWQgdG8gbG9jYWwg
SERNIG1lbW9yeSwgTWVtb3J5X1NpemVbNjM6MjhdIG11c3QgYmUgPiAwOg0KDQooQSA+PiAyOCkg
PCBNZW1vcnlfQmFzZVs2MzoyOF0gKyBNZW1vcnlfU2l6ZVs2MzoyOF0NCg0KVGhpcyBtZWFucyBp
ZiBhIGRldmljZSBhZHZlcnRpc2VzIE1lbW9yeV9TaXplID0gMCwgbm8gaG9zdCBhY2Nlc3Mgd2ls
bA0KcmVzdWx0IGluIGFjY2VzcyB0byB0aGUgSERNIG1lbW9yeS4NCg0KSSB3b3VsZCBhbHNvIG5v
dGUgdGhpcyB0ZXh0IGZyb20gQ1hMIDIuMCBTZWN0aW9uIDguMS4zLjg6DQoiQSBDWEwubWVtIGNh
cGFibGUgZGV2aWNlIGlzIHBlcm1pdHRlZCB0byByZXBvcnQgemVybyBtZW1vcnkgc2l6ZS4iDQoN
CkZvciBhIGRldmljZSB3aXRoIGEgbm9uLXplcm8gY2FwYWNpdHkgbGVzcyB0aGFuIDI1Nk0gdG8g
c2F0aXNmeSB0aGUNCmVxdWF0aW9uLCBpdCB3b3VsZCBuZWVkIHRvIGFkdmVydGlzZSBhIE1lbW9y
eV9TaXplIG9mIGF0IGxlYXN0IDI1Nk0uDQoNClJlZ2FyZHMsDQpBcmllbA0K
