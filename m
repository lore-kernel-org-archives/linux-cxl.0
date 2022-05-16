Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795C0C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 16 May 2022 19:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244580AbiEPTby (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 16 May 2022 15:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345444AbiEPTbw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 16 May 2022 15:31:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752D82C108
        for <linux-cxl@vger.kernel.org>; Mon, 16 May 2022 12:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652729506; x=1684265506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w+9/ygscLr+uToaq8n3ei5gbZvHedNEYc0T058NSWdU=;
  b=GiuCqiAHUQ/5WTEqXMyEmBcBB0/TYPeuyHAAOaRtFjlDbCy1ivthOOGr
   lbelumfNenL8tZsDLeBevZCRuS0iA3gkdmXnllkU2Ex2OE59HHu1Ldq95
   zZmHIY7MlzwHnt/kSaKZIJqAnvGYGU8EQj+XnFDaPtIxGTypOntjQdJvi
   E7+NT3615RPeG9Dsp+PGhW9vLsWjXX9wtlJwX3A9qJLK6d3vXH95jsBfw
   LiCxAhwGjH2r4SyjfN6rH5hSY+yYTSLUT3/eqgtR7BYeqwk88NRNiFzkA
   ypG9wTa3KWRz36xvT33awrvAOHY0tO5LisJtrTYRRUK+qwsgyy+LVIrVA
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,230,1647327600"; 
   d="scan'208";a="173627959"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 May 2022 12:31:45 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 16 May 2022 12:31:45 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 16 May 2022 12:31:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9qc5LlRwlUJIWoLLlP9GPFB43dih/Hw06ep0viaPFHEV8kUBSJ9058viiWkFVD1/QKwM1Uk/3gUUR1qVs/BncQJbxwVf+KsVBki+z1x7x+Q9FH17DfirM6+oZ2NS4zsTcqMA7TVbR3rlcSztWPbG3ztsnllu3yAC2HFo6un2zFAP5HJ38+GIsmPyx8BYiIdVSuN8tEW0KXasB2FGXumctAlOvfKMR105bsG3pDoP3/JKEFPwfK0CB1LXB/MRaZc1TSsRnQ+U67M8VK/ffa/RjF5jeiXLjIeXMRwi0gFKBQ2LxfkN4zbZfGPhvk8jhUW9fjsm25i+CPWdYRRvCg8uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+9/ygscLr+uToaq8n3ei5gbZvHedNEYc0T058NSWdU=;
 b=Eh90xV9oOThOyEoVoDkYit4WbMZ76t1EjvQe5J3ODk7KzE63c66L0aMLPBcqFOMuzPlDr92Em2K3fujxoev9VlgvvUDiSFUWBT1btMw8vMVz2tFbH2u0C+hbbd0W5cjXV6UdqBEdz72lcvBgSh5FSDFDZNW2aRs3YuyX7NOmK188bCil4Uyf2NIkSlIZmN5RMBs9MM4nro20x9vh/4qZBu2WEB1Y1aS3y5gQD/bfyj67d+me/l+vF4AENZf2cw+FQrkUVARzwwqS7TZibgP3XKF9fp9hUkvoIZf2nnVI+DO0ui2qfz6pEbHlXeVvh9tn9ZUDAQR3E0gK0zbUb+CqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+9/ygscLr+uToaq8n3ei5gbZvHedNEYc0T058NSWdU=;
 b=sjU6nCQdAduaeF/GnQpSB411JN6gBg/2xsVlinZK4trc7ghthWhFFFYU3p2Q1rAciFhA+cSqMALmhJxGp/FQ1Vz+dmAXtfBdRX22Q8oiWwrp2Xqifo7ACc6/M+6E0GzWzcOAxXFsG+O5NxZBUIDw3bv2e/GVeq40sBsNgM8gdd8=
Received: from MN2PR11MB3645.namprd11.prod.outlook.com (2603:10b6:208:f8::13)
 by DS7PR11MB6103.namprd11.prod.outlook.com (2603:10b6:8:84::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Mon, 16 May
 2022 19:31:40 +0000
Received: from MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::4d82:9b1a:3a79:df20]) by MN2PR11MB3645.namprd11.prod.outlook.com
 ([fe80::4d82:9b1a:3a79:df20%3]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 19:31:40 +0000
From:   <Ariel.Sibley@microchip.com>
To:     <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <Jonathan.Cameron@huawei.com>,
        <ben.widawsky@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>
Subject: RE: [PATCH 14/14] cxl/port: Enable HDM Capability after validating
 DVSEC Ranges
Thread-Topic: [PATCH 14/14] cxl/port: Enable HDM Capability after validating
 DVSEC Ranges
Thread-Index: AQHYZixlw7dJj1XXI0KFqol8Aex83K0h10jQgAAIjQCAAATXsA==
Date:   Mon, 16 May 2022 19:31:40 +0000
Message-ID: <MN2PR11MB3645C1EE83DC6B05C06A218388CF9@MN2PR11MB3645.namprd11.prod.outlook.com>
References: <165237925642.3832067.15995008431029494571.stgit@dwillia2-desk3.amr.corp.intel.com>
 <165237933127.3832067.12500546479146655886.stgit@dwillia2-desk3.amr.corp.intel.com>
 <MN2PR11MB3645A7AC910531B92FF2260088CF9@MN2PR11MB3645.namprd11.prod.outlook.com>
 <CAPcyv4jN=auUqDz4uA-Oy6CwkvyYPX_F5tB_0wzZK3LP=fBmYQ@mail.gmail.com>
In-Reply-To: <CAPcyv4jN=auUqDz4uA-Oy6CwkvyYPX_F5tB_0wzZK3LP=fBmYQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e25adc1-89a0-4616-66a8-08da3772b359
x-ms-traffictypediagnostic: DS7PR11MB6103:EE_
x-microsoft-antispam-prvs: <DS7PR11MB61037BBDDFCA4343C82826C188CF9@DS7PR11MB6103.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tMxHxvBVY1cXtaATzAyo2GYIEsVnnqSGrqTQB9EzbZsbNTvWCxbjfT6ZDvMW16a7s9aav5QfHr/S6oLdewZIOHsRZ25wojgBf/dJ/vBxWDqrvNQxFX4EbeFOVIwdJQief1BFGPCnAgBKV6Noe33inz0c0WuZD2KhL61b9TFxOUe5UrFSH1t+oCvuIJ3VJV105Kmg3qqCK6x7iabXa3t3QcdZFnC5HtkUcmiCkqvA+kR9vwUNrDzRHpXt7coxxFHAW2FtUTpgcFhCO2ejOWtmByy+i9LXImtZEvQuINdcHFKwf6UbvewyRQ9D2TIPzGYQLUknnOJh89tFGqRypVU+SSLzbytBHdnujANIiN+fQlun4QdK/zXuSYNYKXdVoYLC/cbc1OFiXsR/r3Yx3RDS6jYqalUjJfNc4vVgjK63BXRkHYYDMgCjh4b4SWbz+WdBHmTLXONuCMig48Z/Awwh6+PKEW6LCimpaReUCHJI/bxckxaaZH2L8VCmEGjVE4qViAisR1/I61eMgh0cBwqtQW2H15zqDoTVJB8TzvZTYmMlQH8a7TlUymZk8JSIHXMj+MVVvDxhpZQHAJMYrmomkpc5DggBPbYQtYIjX0sfBHvwpv7LYSwUupBM/Iaad6rm04u7VRj4Hb0B4FWI1B1UumN0/TUq+S2NJacrdcMoo1dNF1gZMXuLb5ugRJNNC/8mAgFOSGkGRO6Ekkh7+W10la3fLXv2kxQYY68i2lr666FCZl4/S6LW3uP0a3R789py
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3645.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(55016003)(52536014)(83380400001)(122000001)(7696005)(186003)(508600001)(5660300002)(38070700005)(38100700002)(86362001)(33656002)(71200400001)(4326008)(66556008)(76116006)(66946007)(8676002)(66476007)(66446008)(64756008)(54906003)(6916009)(6506007)(2906002)(316002)(9686003)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlJEL1FFKy80TWovdFU1UFNLMWhuZXBKUTYyemxCaU1ZMHNBQ1gzeGc1dTVP?=
 =?utf-8?B?K3U0bW84UVBKdXV5UTR2aU9XMzY0SG1TZ0dYWG5EZGh5aDQ5eTFlZTBENDI5?=
 =?utf-8?B?ZXpjS0tWeWx2SEdRVkFVZEN3aFg0alZCRzlROTRwTk5SbkVTRUg3VDhpeEtZ?=
 =?utf-8?B?SHNicjlsa0R0am5yaUdTUVByNzlYRVhhcUQ1Wk05ZFRoVDcwS201eHJ2Y1Ju?=
 =?utf-8?B?STVndnBqQnMyUE9yMGttNHhRb0JSQWFHVVkzRkZKNFAzcmZBTFkrOGpqWU1l?=
 =?utf-8?B?R1hxbXl5cTFKejFxRTB0Z3NvSFBtMklKK0wvbnJkUVRoZW42K1JyRDhsYW0r?=
 =?utf-8?B?dXVkbzZTdThmMjZ6K2U1QytRallxa3Iwd3Fqc3hhcUQyZEVpYTdwMS9VTmJB?=
 =?utf-8?B?RGR2c1RYVytIOEU2VmNDUnBOdTJYY0VkQ0Vrc3pweThCMUpneUJxYlN1ZWhl?=
 =?utf-8?B?T3JWQVBTa3FIU2J6SCtUQ0JwSVFjQ1VsWkt0NWN6V3RhbTdDQ21WQUpjZ2tC?=
 =?utf-8?B?b1ltQ05VZm9JNzhXQ0txN0UwVWN6MVBhV09mV2o1SkRjNmo5WTQ2ajNNVkJE?=
 =?utf-8?B?UzdnZFRURVlSTWZHU0Y0Qi91MnRQcnRWWXpRaWtQcVJCWUkwOVVITG8xb0pQ?=
 =?utf-8?B?Yndzcng3bXFhWkJiRGdwNEJmazJYY0xPdzJuMlYzckZEZkdiY0NqbXdSTEhS?=
 =?utf-8?B?NjFsbGpRajJsT1lva1NFc3ZFWC9NdExneGdUSndIR3N2a3VZalU2TENYZDNU?=
 =?utf-8?B?bGxmYVg3SlYwL3pOSFRlMEpONU5lZWVKY1dDa2Vxa21ZbVgzT2RSb0hrS2lu?=
 =?utf-8?B?MWlFeHJKTlRKdVc2cVlBYTRobzlUMkNVVk5MMFBrOGxDYjhCejN1NG1kdHd4?=
 =?utf-8?B?TnN2WDZMMFhUSnhoVEl2Q2hUUGJEd09yQkZYRWJzREcvUk94MUFYV0hGZm96?=
 =?utf-8?B?eFQ0RWlDWDZuNjNjRDFTOEhjUEcvbnNZUHNIZVhiLzlTTGdCUFB3dmY4aTBx?=
 =?utf-8?B?MGpwTXBaamF0WG15dklST0NCdyszUkNkcU1KUUxNQi9TU2dpMnI1cmMweElY?=
 =?utf-8?B?VWVjQmFQZ0tQaGZlZ3VpV1pFQzBFeHkzZWFMTWFuUlR0WWx5RUpsQkRXQ2hi?=
 =?utf-8?B?TG9USDlyUmhCNUpzcmR4b1NFVFFNaTZ4QjVESjdIOHpRTllZRW90MlZDSEFD?=
 =?utf-8?B?Y0xGTDdjWnBsUzlSb0FncFlpVTN1bEhWZk5jN25CL2JCY3F0MnR0OG1EKzFk?=
 =?utf-8?B?WHB6eGxibDdOaHN5WXUzZ2V1aGlqbTN3VkhpQkVGaXBBeTdjcE9mZ1h3RHhR?=
 =?utf-8?B?bGlLZlJaRUp1eFg0Q3hMRjBUTVdFK01BMnhrVlhKK3llVlRoZGFlV0thQmxQ?=
 =?utf-8?B?Zjl6eHRIeUorWEhxMkNYam9Od0N1SGVmeWlmQ0ZVODNNaXZoMjdXRG9vRjNI?=
 =?utf-8?B?N2c1Sk9oM1RKV1IzVVBmTFViY2FwcmJvbjBZUDFQWXdFbFhjUzdWNXNEa240?=
 =?utf-8?B?V3VWZnVtQU5UYjlIb3o0S0EzQ0tPQ0FZLytET1llQmVIdzYvT01henJ2d1N2?=
 =?utf-8?B?Vzl2enY1TitMV1Vkc3ZpdGJVTm12dTczMTM1LzcxQ2orTVZ4Z0Z0VklNT3RG?=
 =?utf-8?B?RVNIblRmbDFIeTVVTWtieDZtSWVwcENGeHJCWmZVSDNvcHl2QWoyY3kvOHZv?=
 =?utf-8?B?NXFNRzVYb1pNMzNIdmkvTkRFYTFOYW8vQW9Ba2wvREJKaVYzRkpMQzlJZC9S?=
 =?utf-8?B?YWtZSVM3WG11aG5YWWxUdHA1NG9yOFhhcWNmcVBRSlpXL0w0SERPeEJ6b29U?=
 =?utf-8?B?K2JobTBETVpSUFA1V2RVVys0OGJoenpLaDEwRlQvVXhPb3k1Z0xIRFVxR0Ur?=
 =?utf-8?B?SW9BQ0hxZ2t0T3N0SUNuU3NmdEZMUHd6TUd3MUluckdHb1RUbm1ad1JWU2lo?=
 =?utf-8?B?TENzaTJrbzllVVhIdEdBS0RPKzdQOWFWYWZtNDE2QTRIekEyQTIxKzNxS1g4?=
 =?utf-8?B?TGtUc2duYXd4UUQ4TzY3K0I0aWx4Uzh4OXpJQ1RoZTBwOWk0L05kVHZseXp5?=
 =?utf-8?B?RmlpODNaZ09OV095YTJsa0F5SkxXTmVjWDVrb1NzWXpRQjR2UjE1ejFscm5P?=
 =?utf-8?B?YVBXZXlyY3ptZ0MwMDJNUno4U2hUeE4ySWJocXhKQmtWZmpCTWhZVWxBZ0JH?=
 =?utf-8?B?aDZBOFpreXhnV1gzY0xwMWNmRHVUVEFtalRRU2pWZXI5NlFIbnhDN1pFSmhn?=
 =?utf-8?B?VDV1d1lONnN5UysrdEdmYnRNWmtacGlJakpnMXhzb29nQ3NpWjlrYTloMEk0?=
 =?utf-8?B?SHRicWhNeXdQTncvRUpwNmg1SUhhTUhmU3BXUTFoUXVXWFlES0FzUTlWRytr?=
 =?utf-8?Q?Ir9PdbyRMNqvg9XY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e25adc1-89a0-4616-66a8-08da3772b359
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 19:31:40.0657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qmg4QtTKX8KSXFz4wlpHLnPj9rUp7F0smHiRsxCMfFMfOK41AKigiLT/Tot3Fh7YGfMbREvfUHbunH1p+pNWAecdMPVWyjt2GoAJ+v1cdIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6103
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

PiA+ID4gUHJldmlvdXNseSwgdGhlIGN4bF9tZW0gZHJpdmVyIHdhcyByZWx5aW5nIG9uIHBsYXRm
b3JtLWZpcm13YXJlIHRvIHNldA0KPiA+ID4gIm1lbV9lbmFibGUiLiBUaGF0IGlzIGFuIGludmFs
aWQgYXNzdW1wdGlvbiBhcyB0aGVyZSBpcyBubyByZXF1aXJlbWVudA0KPiA+ID4gdGhhdCBwbGF0
Zm9ybS1maXJtd2FyZSBzZXRzIHRoZSBiaXQgYmVmb3JlIHRoZSBkcml2ZXIgc2VlcyBhIGRldmlj
ZSwNCj4gPiA+IGVzcGVjaWFsbHkgaW4gaG90LXBsdWcgc2NlbmFyaW9zLiBBZGRpdGlvbmFsbHks
IEFDUEktcGxhdGZvcm1zIHRoYXQNCj4gPiA+IHN1cHBvcnQgQ1hMIDIuMCBkZXZpY2VzIGFsc28g
c3VwcG9ydCB0aGUgQUNQSSBDRURUIChDWEwgRWFybHkgRGlzY292ZXJ5DQo+ID4gPiBUYWJsZSku
IFRoYXQgdGFibGUgb3V0bGluZXMgdGhlIHBsYXRmb3JtIHBlcm1pc3NpYmxlIGFkZHJlc3MgcmFu
Z2VzIGZvcg0KPiA+ID4gQ1hMIG9wZXJhdGlvbi4gU28sIHRoZXJlIGlzIGEgbmVlZCBmb3IgdGhl
IGRyaXZlciB0byBzZXQgIm1lbV9lbmFibGUiLA0KPiA+ID4gYW5kIHRoZXJlIGlzIGluZm9ybWF0
aW9uIGF2YWlsYWJsZSB0byBkZXRlcm1pbmUgdGhlIHZhbGlkaXR5IG9mIHRoZSBDWEwNCj4gPiA+
IERWU0VDIFJhbmdlcy4gTm90ZSB0aGF0IHRoZSBEVlNFQyBSYW5nZXMgY2FuIG5vdCBiZSBzaHV0
IG9mZiBjb21wbGV0ZWx5Lg0KPiA+ID4gVGhleSBhbHdheXMgZGVjb2RlIGF0IGxlYXN0IDI1Nk1C
IGlmICJtZW1fZW5hYmxlIiBpcyBzZXQgYW5kIHRoZSBIRE0NCj4gPiA+IERlY29kZXIgY2FwYWJp
bGl0eSBpcyBkaXNhYmxlZC4NCj4gPg0KPiA+IFJlZ2FyZGluZyAiY2FuIG5vdCBiZSBzaHV0IG9m
ZiBjb21wbGV0ZWx5IiwgQ1hMIDIuMCBTZWN0aW9uIDguMS4zLjguNA0KPiA+IGhhcyB0aGlzIHN0
YXRlbWVudDoNCj4gPiAtLS0NCj4gPiBBIENYTC5tZW0gY2FwYWJsZSBkZXZpY2UgdGhhdCBkb2Vz
IG5vdCBpbXBsZW1lbnQgQ1hMIEhETSBEZWNvZGVyDQo+ID4gQ2FwYWJpbGl0eSByZWdpc3RlcnMg
ZGlyZWN0cyBob3N0IGFjY2Vzc2VzIHRvIGFuIGFkZHJlc3MgQSB3aXRoaW4gaXRzDQo+ID4gbG9j
YWwgSERNIG1lbW9yeSBpZiB0aGUgZm9sbG93aW5nIHR3byBlcXVhdGlvbnMgYXJlIHNhdGlzZmll
ZCAtDQo+ID4gTWVtb3J5X0Jhc2VbNjM6MjhdIDw9IChBID4+IDI4KSA8IE1lbW9yeV9CYXNlWzYz
OjI4XStNZW1vcnlfU2l6ZVs2MzoyOF0NCj4gPiBNZW1vcnlfQWN0aXZlIEFORCBNZW1fRW5hYmxl
PTENCj4gPiAtLS0NCj4gPg0KPiA+IFBlciB0aGUgYWJvdmUsIGlmIGEgZGV2aWNlIGFkdmVydGlz
ZXMgTWVtb3J5X1NpemUgPSAwLCB0aGVuIHRoZSBmaXJzdA0KPiA+IGVxdWF0aW9uIChzZWNvbmQg
cGFydCkgY2FuIG5ldmVyIGJlIHRydWUuIFNvLCBhIGRldmljZSBhZHZlcnRpc2luZw0KPiA+IE1l
bW9yeV9TaXplID0gMCB3aWxsIGVmZmVjdGl2ZWx5IHNodXQgb2ZmIHRoaXMgcmFuZ2UsIGV2ZW4g
aWYNCj4gPiBNZW1fRW5hYmxlID0gMSBhbmQgdGhlIEhETSBEZWNvZGVyIGNhcGFiaWxpdHkgaXMg
ZGlzYWJsZWQuDQo+IA0KPiBIbW0sIHNvIG5vdyBJIGFtIGNvbmZ1c2VkIGFzIHRvIHdoeSB0aGUg
c3BlYyBnb2VzIG9uIHRvIHNheToNCj4gDQo+ICJJZiB0aGUgYWRkcmVzcyBBIGlzIG5vdCBiYWNr
ZWQgYnkgcmVhbCBtZW1vcnkgKGUuZy4gYSBkZXZpY2Ugd2l0aA0KPiBsZXNzIHRoYW4gMjU2IE1C
IG9mDQo+IG1lbW9yeSksIGEgZGV2aWNlIHRoYXQgZG9lcyBub3QgaW1wbGVtZW50IENYTCBIRE0g
RGVjb2RlciBDYXBhYmlsaXR5IHJlZ2lzdGVycw0KPiBtdXN0IGhhbmRsZSB0aG9zZSBhY2Nlc3Nl
cyBncmFjZWZ1bGx5IGkuZS4gcmV0dXJuIGFsbCAx4oCZcyBvbiByZWFkcyBhbmQNCj4gZHJvcCB3
cml0ZXMuIg0KPiANCj4gVGhpcyBpcyB3aGF0IGxlZCBtZSB0byBjb25jbHVkZSB0aGF0IGV2ZW4g
dGhvdWdoIE1lbW9yeV9TaXplIGlzIDAsIHRoZQ0KPiBkZXZpY2UgaXMgc3RpbGwgYWN0aXZlbHkg
ZGVjb2RpbmcgWzAsIDI1Nk1CKS4NCg0KTXkgaW50ZXJwcmV0YXRpb24gb2YgdGhhdCBzdGF0ZW1l
bnQgaXMgdGhhdCBzdWNoIGEgZGV2aWNlIHdvdWxkIG5lZWQgdG8NCmFkdmVydGlzZSBhIGNhcGFj
aXR5IG9mIDI1Nk0sIGFuZCBiZWhhdmUgcGVyIHRoZSB0ZXh0IGZvciB0aGUgcG9ydGlvbiBvZg0K
dGhlIDI1Nk0gcmFuZ2Ugbm90IGJhY2tlZCBieSBwaHlzaWNhbCBtZW1vcnkuIFN1Y2ggYSBkZXZp
Y2Ugd291bGQgYmUgDQpwcm9ibGVtYXRpYyBmb3IgdGhlIGhvc3QgdG8gaGFuZGxlLCBhcyBJJ20g
bm90IHN1cmUgaG93IHRoZSBob3N0IHdvdWxkIGJlIA0KYWJsZSB0byBkZXRlcm1pbmUgdGhlIHBv
cnRpb24gb2YgdGhlIHJhbmdlIHRoYXQgaXMgdXNhYmxlLiBBcyBzdWNoLCBJDQpkb24ndCB0aGlu
ayBidWlsZGluZyBzdWNoIGEgZGV2aWNlIHdvdWxkIGJlIHByYWN0aWNhbC4NCg0KVGhlcmUgYXJl
IHNldmVyYWwgb3RoZXIgbG9jYXRpb25zIGluIHRoZSBDWEwgMi4wIHNwZWMgdGhhdCBpbmRpY2F0
ZSB0aGF0DQpkZXZpY2VzIG11c3QgbWFuYWdlIGNhcGFjaXR5IGluIHVuaXRzIG9mIDI1Nk0uIEUu
Zy4gVGFibGUgMTc1LiBJZGVudGlmeQ0KTWVtb3J5IERldmljZSBPdXRwdXQgUGF5bG9hZC4NCg0K
UmVnYXJkcywNCkFyaWVsDQo=
