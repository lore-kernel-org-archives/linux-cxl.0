Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 935C5C4332F
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Nov 2022 00:35:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiKIAf0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 19:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKIAfY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 19:35:24 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA4663150
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 16:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667954124; x=1699490124;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XFkjog79ythCOLdtro6lRpmO5LDXhgPo8xL4/LguOp0=;
  b=RW5ji0zxs+c0HAoOa2Fi0O2MalnXGkG0Emi+EHyl/l9N+C/Stb7VBC5y
   IuyTSPkVOLTl5Hb5ugYzxPCXVcKXFVZ/Ii7RSB7x5PWG+gaG1u+HorwTH
   Bt1/MNutgOdbS9DwgGIIBSODkedeaij4m5l+aYfUIAvcNXqPILrZvAeJG
   ZOsLcw7LftkgaprsCwOAz69rAHqD9Q4ZnehqwNe1sWOg2fnkEgOnQQSxI
   oLP1lXgCYUazlriKGozhkmfrvweKExXzbRHuRxen1og9OyxKOEmZGD9Oo
   7mKQz5EEuet4xYgsqRkDJhTyu+Hgq4Bei1anCYJHngxUV25gZ59wywuuD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="308466716"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="308466716"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 16:35:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="636533665"
X-IronPort-AV: E=Sophos;i="5.96,149,1665471600"; 
   d="scan'208";a="636533665"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 08 Nov 2022 16:35:23 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 16:35:23 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 8 Nov 2022 16:35:22 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 8 Nov 2022 16:35:22 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 8 Nov 2022 16:35:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgU89tLRXV6QbpG4ugkG8DavHEjnIMjfvfCEMb/qG+YPAxTm8JCOZumdtYgPgVyDbVDfdBUFc0SxvKiCF5wkNJBOPxq52oBef7egGh4mIGV76/t8QvoONq7xtkeptZKc0bBPSOXsjNJxWAjPlcaEDVfGA8X0UBVaCVZKojPe2aMQAbHX2VjFHj+1JYYlq+vkoI1vuoKgp1Swm6nVCIZ3SZTOIlrCVjD1JqdOTVjYhIPZtD7YtvQdHuN6eZ7x0NO0VgynEdSZtVAbdJI9Ma6Z/K9SZONPz5AM1/QVUPqL9LX+HrEmf2vPVo1JYwdboaknOVvBZxmUs6MxGE4HvKnNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XFkjog79ythCOLdtro6lRpmO5LDXhgPo8xL4/LguOp0=;
 b=R+ZEFj3SMRixc5TZWmlbfnMo1drRCCVC9hQe+fdc6jVW6Ju2NRsc4bI9ojAqZ4OH77c05iQr7K1GHGq3ATlijr7zQ8E8WqAN9IOcftMaq62DKv7frdoiaxpaW3Y26czFE5soQ8HC9LcrTQ1kk9gN5UUVGFbGtMkg3Rpl5oVWFW+TxpDDvL8BqR3YaOpnhPOMa25AtU8DHf9psYdQg8+YaekpuZWM+7+9/hUhgUvDscsWzVKmFJMJTiVlwIGAXbJ2Wqx2SNN+kPVa2mKPSYpb3hfY52A1todNpwcJKB/z+96cOLV4x8acGtivf2MvbC9dtwVWpBieSLZp5Pwv/nGOcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by BN9PR11MB5498.namprd11.prod.outlook.com (2603:10b6:408:103::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Wed, 9 Nov
 2022 00:35:20 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e%7]) with mapi id 15.20.5791.026; Wed, 9 Nov 2022
 00:35:20 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Jiang, Dave" <dave.jiang@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH v4 07/10] cxl: add monitor command to cxl
Thread-Topic: [PATCH v4 07/10] cxl: add monitor command to cxl
Thread-Index: AQHY86A+AMR8s3mI+Uq8Xf7l91LlSq41vwmA
Date:   Wed, 9 Nov 2022 00:35:20 +0000
Message-ID: <d151fb82ffc433b583a9d10f6a9c3f5018d2f337.camel@intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
         <166793222841.3768752.2390044444606875734.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793222841.3768752.2390044444606875734.stgit@djiang5-desk3.ch.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|BN9PR11MB5498:EE_
x-ms-office365-filtering-correlation-id: 578fac10-525f-4125-c1b2-08dac1ea4807
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z4kjE8N6D6LEoOWzaQHFF0YYaPh2h8Zm8OP4WJg5MrNMbo2j9PEbO17YOenYjZPEsO0nvlNQfUwH6/uNdqqtKdK+JZWscdykzIukJ9tRcETOSSKp+xoHAnWj6JOJOPRrhDL+UfKZLlrxbmmrgdwh4mfAzMxIG+uJUQOIUPVdCjT2+u7p+Oc+GVyeFyvq1YRzzjulkJa+C3grvrUbaFaF0iuq1Djv+Zy66Ufg0IyiJJWeCY8SyZxgRTo+oOb3vd4p8WF6bDDd+ISGs/vIrK7fFdhW/xen9JK8ZZ+TN/tIGS/QlK5cjtsbGjLjiqcSc7ZGwJy7j40i3mZ0mZDRzyGj9PqxOMJbzOMiCtGYEIkCWnplC4Dr3IVYaNyFw68ofeQWCCViCkFLuSs4DTN4dN4A7yyBVGxPe0PE/gw1WCIsF/UQhp7aFjmdaxJVGqVM+fMPRl5Vjz8Aqbhn3hDgvIYsD8UTK2qn6SxSWedfoJkLd1sC/O9BxVmIyhb+1cKPJh4EI00kHjjBuNMj0RN+NBup9GPb7bKGBmrJmmQ5nRbqgcvlLTwG0S9m3XozKsbonZbSv4w3xCcBaYXgQmMd8wqr9pxn3msiac/7bRut5sR2kOvmC1a27vfR2n/zpkBGAQQ42Wo1UPgi4N/pMc8VA6+a1b7FI2q5GeQnVv2mU7H9J1KZV7ddFV+P0ursTYH5KD8bk8RrFziT4XNUau8tHQQxhIgGbUOe5WyIxwaWL+uWvKfdZHc0DDe2f5ZqcX/eoKXZncwSoSy9BqO5UZks8a7aBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(136003)(346002)(396003)(366004)(376002)(451199015)(2906002)(36756003)(107886003)(5660300002)(316002)(110136005)(54906003)(66556008)(66476007)(66446008)(64756008)(66946007)(4326008)(76116006)(91956017)(8676002)(478600001)(8936002)(41300700001)(6486002)(71200400001)(83380400001)(38070700005)(122000001)(38100700002)(82960400001)(6506007)(86362001)(6512007)(26005)(186003)(2616005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1RJUTNhVU8rSWZyMWhETWJsMmFYRVBHVi9Ob2poaGtOeklEUXhjMCt2YzlY?=
 =?utf-8?B?ck0xZmJ4RWk0aDA2c2lkYjFvZnBnYWpsaE1YMFE4QkRTSUlFWTQ2UnJjWjBJ?=
 =?utf-8?B?OUNBcnlrMHVhUEJBMjBwNWt4ZWhXZnNPT3VtajV6UVFPbDA1a3Jrakh6c3Nh?=
 =?utf-8?B?b3dNTEV1bWNmOUg3OFlDQVFHam9icjVNbS9aUEVJenlUSWxvOEJWazFvNnNS?=
 =?utf-8?B?TUcxMjNwSHkreGpCL2kzYy8zOHM4ckxDVDdHMHJCdlhPNnhwRUQrZnJkWXdn?=
 =?utf-8?B?bi9rZUpRN0N4UFVudDVDNWxFMTBCR1hDL3NrbVhiajNEOHdsQnpHUFZ5aDJq?=
 =?utf-8?B?RVhQMTRHVWJUbkluOUpFbnByc09ZSWxsQldFdTZFU3I2aFllRkp6OFpaM0Nq?=
 =?utf-8?B?dlEwK2tZb2JRdjFHYWFBa2R2N0xQcEJQaEx3RzVjcHpzc3orVXM5a2tVSksv?=
 =?utf-8?B?RnQxc0NWTnlCNitWc1cyQTg0ZjdkbEEwTzhMWHc3UVV4MWFVVTFMN3p4dHpH?=
 =?utf-8?B?eVZDUmZqL1pzVmE2ZkJOc04yblU0T0xLNW5vWUROUHVtZWdKc1FoNFRId0JO?=
 =?utf-8?B?V01HcXdWTXY0NDNxTTVvc3pYaVFWa0JmSFl5a1AxdUlQMEpyZEJDWE5JTG1R?=
 =?utf-8?B?Nk9IbWpUbEdpTFBEZ0NqKzdqZWhFRDV5UFY0ZUppMFEyZDNKNDE4TW5pQVVq?=
 =?utf-8?B?UG5pMlprWTBISGxRT204dkxEOE5HY2ZxUG92N0tiUkRxVmZWRmQ5Tmdjb3JC?=
 =?utf-8?B?aDNReFJpRnphL1FlTGh1KzVJMUM0NEJMUVJ5cEdhOGY2UzRpQ3Eyc3psVTMv?=
 =?utf-8?B?ckhTNEZRRWYrMFh2ZGNudGt4bjNWNTN6ZnlMS0UrZTdWVFREYTBrVWVPcTI0?=
 =?utf-8?B?NGs1cTljWXRPbGdacnVvYkVlV0t2cjJ5UTR0WDhZYkJUcHFVV0VIamkvRGZS?=
 =?utf-8?B?UmtORUZsczBobWFWek9WZnRtZ0dCSnFNVngzWlNVOEljRExncWF5a0ZKVFU4?=
 =?utf-8?B?NEs3QUpZZitqUVN6bmwvbXlZSTdQTThsOWNIc1R5RzJ0d3VuRXo2VTRMakgx?=
 =?utf-8?B?cHFqcXh4WDFaTFNUamtzU3BDSWlnVERFdFQxOWNnakYwejJtWHRQaDhnVVF4?=
 =?utf-8?B?UTd4Z2lIN25GV2wrbE9yeWF6c2VJdmFzUUFCdDhheDZCRTRQN25HUk1DZDN3?=
 =?utf-8?B?NTdrNGhrWGFiZG05UThCS1kxSjFnMmE1Wno1RGs4STJURjRTSUJUUEVEMFhq?=
 =?utf-8?B?ZjNjcDEzWTE0NkNJYk1kbTIyRlJGcDRmc0w4Q0htbStKVm1vaHFLRzN3TVN4?=
 =?utf-8?B?TGJad1hQU2ZoaG1zdnBHNzRxR0p0dy9lbVZDajlGeHBSUHBtYmIwcE02WW9O?=
 =?utf-8?B?OXgwUy9kSFNnd2VuQVhsN0o3eXNIN0xpVzg0MG5RUUhpOVpCY1NLN3JwVmYz?=
 =?utf-8?B?Yy9JK2dOZXlKY2JreG1mdmF3c2dKQU9qZCs0QnJpMllFNWtoNmdiayszckFo?=
 =?utf-8?B?V3dHZllNMnJiWDRwUTBCSkRSZ3lyZ1ZnWlRNM3lpNTNURHJtcWUwSkZQOEF2?=
 =?utf-8?B?ekk5dURJYzZsVkh1K0hITlZzRGl3Q0Jib2hnNnk1WlRiZlc4Qm9pMUUrK0JJ?=
 =?utf-8?B?ZVdQTkdTWnhKL2VKWVhjdEhCWTRaT1hpMXhRWjgzMnE1U292Q1huTmozN29s?=
 =?utf-8?B?Uk9vaXY5UE5jcUEzUDVxMW1mcmUvRDcrTk45bmFreEN0aEFGd0ZGZjUrRU16?=
 =?utf-8?B?UFdxMGtkZ1c3bUc3UGR6MG1KdGJCVEZTY1pveGtGT20zdDdUN1RuUVRMS0NY?=
 =?utf-8?B?Y21zTlJlT1lNT1hic01qeUtZdG5sa0RLK2tCYnhDRFlrN2ZtWjN4UUlmWlR5?=
 =?utf-8?B?SXVjamsrTG52UjdxTWxGNjVJaDlxNW4yVlFBSW12RlZIQ05nSUN5RGFLVzhC?=
 =?utf-8?B?VkFXM2Uvb0FvRmZiRDdrR2xxcEJBZEhBMlE5L1had1FjYzFJV3VUZWE5TTc1?=
 =?utf-8?B?UE1SNG1nbWxXS0JTRnNpbWFNdVVyK3lBbzZieDMzT0tVWjlNZDBQYkpWWW55?=
 =?utf-8?B?OC8zRnRVWGVKNDE3ZG1MSjc5WUU1NStGMkNtYU5TWnZISHhlaW9NYmFSeit1?=
 =?utf-8?B?RkhJaGpQSTZCdVZlT0IraTBLbEVod0wzKzJPZ1ZsYnJtb0ZHT21wK2lpTDdy?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <073A21AB60935644922AA25CB67EB909@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578fac10-525f-4125-c1b2-08dac1ea4807
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2022 00:35:20.0541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mOs6ANfI6peZ4sjD+jIul5gBBED5vaGWo3Y4ELPAWoOox38IC+DMkGF0A2ZWk8b0qQspD7kBYn1XS/OQmhIZVSYyzc0K56de0Pkigshe2aI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5498
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVHVlLCAyMDIyLTExLTA4IGF0IDExOjMwIC0wNzAwLCBEYXZlIEppYW5nIHdyb3RlOgo+IENv
bm5lY3QgdGhlIG1vbml0b3JpbmcgZnVuY3Rpb25hbGl0eSB0byB0aGUgY3hsIG1vbml0b3IgY29t
bWFuZC4gQWRkIGJhc2ljCj4gZnVuY3Rpb25hbGl0eSB0byB0aGUgY3hsIG1vbml0b3IgY29tbWFu
ZCB3aGVyZSBpdCBjYW4gYmUgbGF1bmNoZWQgYXMgYSBkYWVtb24KPiBhbmQgbG9nZ2luZyBjYW4g
YmUgZGVzaWduYXRlZCB0byBzdGRvdXQgb3IgYSBmaWxlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IERh
dmUgSmlhbmcgPGRhdmUuamlhbmdAaW50ZWwuY29tPgo+IC0tLQo+IMKgY3hsL2J1aWx0aW4uaCB8
wqDCoMKgIDEgKwo+IMKgY3hsL2N4bC5jwqDCoMKgwqAgfMKgwqDCoCAxICsKPiDCoGN4bC9tb25p
dG9yLmMgfMKgwqAgNzUgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCj4gwqAzIGZpbGVzIGNoYW5nZWQsIDc3IGluc2VydGlvbnMoKykKCkZl
ZWxzIGxpa2VlIHRoaXMgcGF0Y2ggc2hvdWxkIGJlIHNxdWFzaGVkIHdpdGggcGF0Y2ggNS4gVW5s
ZXNzIHRoZXJlJ3MKYW4gdW5kZXJseWluZyByZWFzb24gZm9yIHRoZSBzcGxpdCBJJ20gbWlzc2lu
ZywgdGhlIHN0YW5kYWxvbmUgYWRkaXRpb24Kb2YgdGhlIG1vbml0b3JfZXZlbnQoKSBmdW5jdGlv
biBkb2Vzbid0IGRvIGFueXRoaW5nLCBhbmQgZG9lc24ndCBmZWVsCmxpa2UgYSBjbGVhbiBicmVh
ayBldmVuIGZvciByZXZpZXdhYmlsaXR5LgoKPiAKPiBkaWZmIC0tZ2l0IGEvY3hsL2J1aWx0aW4u
aCBiL2N4bC9idWlsdGluLmgKPiBpbmRleCBiMjhjMjIxMzk5M2IuLjM0YzVjZmI0OTA1MSAxMDA2
NDQKPiAtLS0gYS9jeGwvYnVpbHRpbi5oCj4gKysrIGIvY3hsL2J1aWx0aW4uaAo+IEBAIC0yMiw0
ICsyMiw1IEBAIGludCBjbWRfY3JlYXRlX3JlZ2lvbihpbnQgYXJnYywgY29uc3QgY2hhciAqKmFy
Z3YsIHN0cnVjdCBjeGxfY3R4ICpjdHgpOwo+IMKgaW50IGNtZF9lbmFibGVfcmVnaW9uKGludCBh
cmdjLCBjb25zdCBjaGFyICoqYXJndiwgc3RydWN0IGN4bF9jdHggKmN0eCk7Cj4gwqBpbnQgY21k
X2Rpc2FibGVfcmVnaW9uKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndiwgc3RydWN0IGN4bF9j
dHggKmN0eCk7Cj4gwqBpbnQgY21kX2Rlc3Ryb3lfcmVnaW9uKGludCBhcmdjLCBjb25zdCBjaGFy
ICoqYXJndiwgc3RydWN0IGN4bF9jdHggKmN0eCk7Cj4gK2ludCBjbWRfbW9uaXRvcihpbnQgYXJn
YywgY29uc3QgY2hhciAqKmFyZ3YsIHN0cnVjdCBjeGxfY3R4ICpjdHgpOwo+IMKgI2VuZGlmIC8q
IF9DWExfQlVJTFRJTl9IXyAqLwo+IGRpZmYgLS1naXQgYS9jeGwvY3hsLmMgYi9jeGwvY3hsLmMK
PiBpbmRleCBkZDFiZTdhMDU0YTEuLjNiZTcwMjZmNDNkMyAxMDA2NDQKPiAtLS0gYS9jeGwvY3hs
LmMKPiArKysgYi9jeGwvY3hsLmMKPiBAQCAtNzYsNiArNzYsNyBAQCBzdGF0aWMgc3RydWN0IGNt
ZF9zdHJ1Y3QgY29tbWFuZHNbXSA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgeyAiZW5hYmxlLXJlZ2lv
biIsIC5jX2ZuID0gY21kX2VuYWJsZV9yZWdpb24gfSwKPiDCoMKgwqDCoMKgwqDCoMKgeyAiZGlz
YWJsZS1yZWdpb24iLCAuY19mbiA9IGNtZF9kaXNhYmxlX3JlZ2lvbiB9LAo+IMKgwqDCoMKgwqDC
oMKgwqB7ICJkZXN0cm95LXJlZ2lvbiIsIC5jX2ZuID0gY21kX2Rlc3Ryb3lfcmVnaW9uIH0sCj4g
K8KgwqDCoMKgwqDCoMKgeyAibW9uaXRvciIsIC5jX2ZuID0gY21kX21vbml0b3IgfSwKPiDCoH07
Cj4gwqAKPiDCoGludCBtYWluKGludCBhcmdjLCBjb25zdCBjaGFyICoqYXJndikKPiBkaWZmIC0t
Z2l0IGEvY3hsL21vbml0b3IuYyBiL2N4bC9tb25pdG9yLmMKPiBpbmRleCA1MThkODE0MmU0MGQu
LmQ4ZTQ5ODM5MmVkNyAxMDA2NDQKPiAtLS0gYS9jeGwvbW9uaXRvci5jCj4gKysrIGIvY3hsL21v
bml0b3IuYwo+IEBAIC0zMiwxMSArMzIsMTUgQEAKPiDCoCNpbmNsdWRlICJldmVudF90cmFjZS5o
Igo+IMKgCj4gwqBzdGF0aWMgY29uc3QgY2hhciAqY3hsX3N5c3RlbSA9ICJjeGwiOwo+ICtjb25z
dCBjaGFyICpkZWZhdWx0X2xvZyA9ICIvdmFyL2xvZy9jeGwtbW9uaXRvci5sb2ciOwo+IMKgCj4g
wqBzdGF0aWMgc3RydWN0IG1vbml0b3Igewo+ICvCoMKgwqDCoMKgwqDCoGNvbnN0IGNoYXIgKmxv
ZzsKPiDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGxvZ19jdHggY3R4Owo+IMKgwqDCoMKgwqDCoMKg
wqBGSUxFICpsb2dfZmlsZTsKPiDCoMKgwqDCoMKgwqDCoMKgYm9vbCBodW1hbjsKPiArwqDCoMKg
wqDCoMKgwqBib29sIHZlcmJvc2U7Cj4gK8KgwqDCoMKgwqDCoMKgYm9vbCBkYWVtb247Cj4gwqB9
IG1vbml0b3I7Cj4gwqAKPiDCoHN0YXRpYyB2b2lkIGxvZ19zdGFuZGFyZChzdHJ1Y3QgbG9nX2N0
eCAqY3R4LCBpbnQgcHJpb3JpdHksIGNvbnN0IGNoYXIgKmZpbGUsCj4gQEAgLTE2MywzICsxNjcs
NzQgQEAgZXBvbGxfZXJyOgo+IMKgwqDCoMKgwqDCoMKgwqBmcmVlKGV2ZW50cyk7Cj4gwqDCoMKg
wqDCoMKgwqDCoHJldHVybiByYzsKPiDCoH0KPiArCj4gK2ludCBjbWRfbW9uaXRvcihpbnQgYXJn
YywgY29uc3QgY2hhciAqKmFyZ3YsIHN0cnVjdCBjeGxfY3R4ICpjdHgpCj4gK3sKPiArwqDCoMKg
wqDCoMKgwqBjb25zdCBzdHJ1Y3Qgb3B0aW9uIG9wdGlvbnNbXSA9IHsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgT1BUX0ZJTEVOQU1FKCdsJywgImxvZyIsICZtb25pdG9yLmxvZywK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAiPGZpbGU+IHwgc3RhbmRhcmQiLAo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJ3aGVyZSB0byBvdXRwdXQgdGhl
IG1vbml0b3IncyBub3RpZmljYXRpb24iKSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgT1BUX0JPT0xFQU4oJ1wwJywgImRhZW1vbiIsICZtb25pdG9yLmRhZW1vbiwKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAi
cnVuIGN4bCBtb25pdG9yIGFzIGEgZGFlbW9uIiksCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoE9QVF9CT09MRUFOKCd1JywgImh1bWFuIiwgJm1vbml0b3IuaHVtYW4sCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
InVzZSBodW1hbiBmcmllbmRseSBvdXRwdXQgZm9ybWF0cyIpLAo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBPUFRfQk9PTEVBTigndicsICJ2ZXJib3NlIiwgJm1vbml0b3IudmVyYm9z
ZSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAiZW1pdCBleHRyYSBkZWJ1ZyBtZXNzYWdlcyB0byBsb2ciKSwKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgT1BUX0VORCgpLAo+ICvCoMKgwqDCoMKgwqDCoH07Cj4g
K8KgwqDCoMKgwqDCoMKgY29uc3QgY2hhciAqIGNvbnN0IHVbXSA9IHsKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgImN4bCBtb25pdG9yIFs8b3B0aW9ucz5dIiwKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgTlVMTAo+ICvCoMKgwqDCoMKgwqDCoH07Cj4gK8KgwqDCoMKg
wqDCoMKgY29uc3QgY2hhciAqcHJlZml4ID0iLi8iOwo+ICvCoMKgwqDCoMKgwqDCoGludCByYyA9
IDAsIGk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGFyZ2MgPSBwYXJzZV9vcHRpb25zX3ByZWZpeChh
cmdjLCBhcmd2LCBwcmVmaXgsIG9wdGlvbnMsIHUsIDApOwo+ICvCoMKgwqDCoMKgwqDCoGZvciAo
aSA9IDA7IGkgPCBhcmdjOyBpKyspCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGVy
cm9yKCJ1bmtub3duIHBhcmFtZXRlciBcIiVzXCJcbiIsIGFyZ3ZbaV0pOwo+ICvCoMKgwqDCoMKg
wqDCoGlmIChhcmdjKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1c2FnZV93aXRo
X29wdGlvbnModSwgb3B0aW9ucyk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGxvZ19pbml0KCZtb25p
dG9yLmN0eCwgImN4bC9tb25pdG9yIiwgIkNYTF9NT05JVE9SX0xPRyIpOwo+ICvCoMKgwqDCoMKg
wqDCoG1vbml0b3IuY3R4LmxvZ19mbiA9IGxvZ19zdGFuZGFyZDsKPiArCj4gK8KgwqDCoMKgwqDC
oMKgaWYgKG1vbml0b3IudmVyYm9zZSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
bW9uaXRvci5jdHgubG9nX3ByaW9yaXR5ID0gTE9HX0RFQlVHOwo+ICvCoMKgwqDCoMKgwqDCoGVs
c2UKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9uaXRvci5jdHgubG9nX3ByaW9y
aXR5ID0gTE9HX0lORk87Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlmIChtb25pdG9yLmxvZykgewo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoc3RybmNtcChtb25pdG9yLmxvZywg
Ii4vIiwgMikgIT0gMCkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoGZpeF9maWxlbmFtZShwcmVmaXgsIChjb25zdCBjaGFyICoqKSZtb25pdG9yLmxvZyk7
Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChzdHJuY21wKG1vbml0b3IubG9n
LCAiLi9zdGFuZGFyZCIsIDEwKSA9PSAwICYmICFtb25pdG9yLmRhZW1vbikgewo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbW9uaXRvci5jdHgubG9nX2Zu
ID0gbG9nX3N0YW5kYXJkOwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9IGVsc2Ug
ewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgY29uc3Qg
Y2hhciAqbG9nID0gbW9uaXRvci5sb2c7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFtb25pdG9yLmxvZykKPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsb2cgPSBkZWZh
dWx0X2xvZzsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oG1vbml0b3IubG9nX2ZpbGUgPSBmb3Blbihsb2csICJhKyIpOwo+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFtb25pdG9yLmxvZ19maWxlKSB7Cj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcmMgPSAtZXJybm87Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZXJyb3IoIm9wZW4gJXMgZmFpbGVkOiAlZFxuIiwg
bW9uaXRvci5sb2csIHJjKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH0KPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoG1vbml0b3IuY3R4LmxvZ19mbiA9IGxvZ19maWxlOwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKPiAr
wqDCoMKgwqDCoMKgwqBpZiAobW9uaXRvci5kYWVtb24pIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgaWYgKGRhZW1vbigwLCAwKSAhPSAwKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlcnIoJm1vbml0b3IsICJkYWVtb24gc3RhcnQg
ZmFpbGVkXG4iKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoGdvdG8gb3V0Owo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB9Cj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGluZm8oJm1vbml0b3IsICJjeGwgbW9uaXRvciBkYWVt
b24gc3RhcnRlZC5cbiIpOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4gK8KgwqDCoMKgwqDCoMKg
cmMgPSBtb25pdG9yX2V2ZW50KGN0eCk7Cj4gKwo+ICtvdXQ6Cj4gK8KgwqDCoMKgwqDCoMKgaWYg
KG1vbml0b3IubG9nX2ZpbGUpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGZjbG9z
ZShtb25pdG9yLmxvZ19maWxlKTsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gcmM7Cj4gK30KPiAK
PiAKCg==
