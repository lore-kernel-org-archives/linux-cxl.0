Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEFE9C4332F
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Nov 2022 06:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiKDGb2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Nov 2022 02:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKDGbY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Nov 2022 02:31:24 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A1E429352
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 23:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667543480; x=1699079480;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=oOZ9JoQUeuBjzR9K6W+fReqNjyTWF448nUITZsoWEuU=;
  b=NU9ZVgYhrqWaFd2GPpNqXhoxNN+ijajQJ4WIQuv1cGPYcAJoLgpHfn88
   TceBDeEUtcPxQQHuf0I8yMfNWImCvrIc31pkKoWkhhjSKX1Z+OXY2mB0E
   r6jWb2lx0/FJII4/0BUe97J1vozHb3+UO32WUtWZgxm9VecNqupig+Pea
   fEuVMkV9dqUn+dhzxOQxYSTXml78TJqLpCMelISzGApNabB4Xx+PlIZBq
   Vnv9Pd2QgaoVnDEEtF1zzYN3cWM/cqQKVlTftlLjCSdaUOogQe+ao1b5p
   j3J9EAwLGOYKwk6+du820lQp+MpojKV99erLxkUcrnhr6zyB0eVN/y43m
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="290282279"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="290282279"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2022 23:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10520"; a="586084335"
X-IronPort-AV: E=Sophos;i="5.96,136,1665471600"; 
   d="scan'208";a="586084335"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 03 Nov 2022 23:31:19 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 23:31:18 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 23:31:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 3 Nov 2022 23:31:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 3 Nov 2022 23:31:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDabcVvx0C6BvSLnqaAm7t7PW1jCEEWtsOU0qQXI7OAVG39zcrPQn84kE6fl91nj37xK656lRVH0zQqliuEochye3sWxt8lLAexvrXfaHrXptrV3z+sRwIXMTk2d7OOIjjG/oQdpUh5ja+iIwIa5bXXXeGtq3mlpvwqX4n4nQ1z5a0+ZVspNCsiNN8rwGP9qDxHr1aK9VyoigZQCQD2MM6wBErPiodvlePVXmy3j+qxByzecKC263er30Nst9krwMRe6OpjwDLyglQVbHKZml7Wsn3kDH9AVgY3giMMECe5Jya9bCWugEriWI5tgKk+/HYBFATD1zkMgNoiWe5WkuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oOZ9JoQUeuBjzR9K6W+fReqNjyTWF448nUITZsoWEuU=;
 b=WqKop23v5ulWssM6RXfImVD5oYADjNAn5kJbVcs6tueOVAyggYfkGeEeOE0mBkksQDE4dCXPg+D1RwvnvX/l1iRvaeB7BBEIeloukD5LUvobEBLtUvtR8w+xKGpNb+8Sxtj65w6gw9XlkX/+/Tos3jsHqroTTgdw+eU3DPEAK+320LkvusiTJGLbkXJKODd+pJj6EnkkvCQW4bGpIwmc70KM+Q6aTY3lDKYUzQi6/Rxc+ty/AceAFOFD9UUkJvJ1/GffXO1etFnlM3vwy/XcUI5bGiqJo/Zi9dZL7Q943bqVdKhy7syTE5joCKgQ4XvRdiyHRZVzhrmcURazA8fSsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3999.namprd11.prod.outlook.com (2603:10b6:208:154::32)
 by BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.20; Fri, 4 Nov
 2022 06:31:15 +0000
Received: from MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e]) by MN2PR11MB3999.namprd11.prod.outlook.com
 ([fe80::c275:940e:a871:646e%7]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 06:31:15 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC:     "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>
Subject: Re: [PATCH 7/7] cxl/region: Recycle region ids
Thread-Topic: [PATCH 7/7] cxl/region: Recycle region ids
Thread-Index: AQHY7+S9f5Q5toADBE2l76SIw5Rux64uTkkA
Date:   Fri, 4 Nov 2022 06:31:15 +0000
Message-ID: <cbc5c4881b98bd4bd6d75279e695575ed5dc3e49.camel@intel.com>
References: <166752181697.947915.744835334283138352.stgit@dwillia2-xfh.jf.intel.com>
         <166752186062.947915.13200195701224993317.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <166752186062.947915.13200195701224993317.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3999:EE_|BL3PR11MB6532:EE_
x-ms-office365-filtering-correlation-id: a7f2de02-d576-4aa7-71fe-08dabe2e2cc3
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BNdRxaOti8GQa712a361xwUaQk0QOtmH1tR/r2dpn1izPL08x579c/ulG5UMZbf5ooNTsuu/IgD2z/pru0YS/275mSNPhKLMIdpXYjob+3CNgJ+fW8NKFrFchkU+reRUVadLhTJQFiuBM6kXtVG4M9l3FSBAlDW3BC+OPQT+mqMFQrD6u+t4V3clBhkAP2wiDlQEPSxBGoUz1jQhA2V59DBzi/dLbHuAlkmyQOOeywvnpnrkPoHCFiKEG7VPa/9qVurLFDSq3p1fz9Whg11C66hearjl2IodwVhP9t+SiyE1PC6UKdx6LBovE+56TFw+kY3LugOh4vET7M2C5rUshU0qzmpcUuJ+y+/HlUQRaq6libm0sbZDlvLcESHvnl05MZdaktaacB8zYCKxjM7Jb+m0YUu7sRCoeqVXYea9dC/C7EQfMUKTMc1fU48/zDxyREGcKJygJOznaB+KtfDrmUYRXCiajjX0rBVBfbUk58gCYwT7eiCSnWMeCrCloCSU9QJHhK0mP4v20R/QntWPpWtrSrKBd2bum94MsN+M2neoZyLOO4tpRjHrUZucg0S8IIIA4mJmK1mOF2cdkbWPgADmuEfD4htukvxCr6Sj7tFNcuqeV2jBRqXOKEVqslMp4MYaxH6rZOoWCF5jiw/k2aEot62RPsuVqKIdoyw0pqU4ZDn4mdzBarQRjdUKjzeeGctJUI2USbKQbxjhZ3SLaB+7Jfsmuv4FAuU3w1AjnYLghvsw+l1kX2Q75TMb7kiIjqO2U1rPL+GkLiDG3hqExA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3999.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199015)(316002)(122000001)(38070700005)(71200400001)(82960400001)(54906003)(41300700001)(6486002)(110136005)(4326008)(91956017)(66476007)(478600001)(8676002)(8936002)(66446008)(66556008)(66946007)(83380400001)(38100700002)(76116006)(64756008)(2616005)(5660300002)(107886003)(186003)(26005)(36756003)(6506007)(6512007)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aTZGaHdhcDl3K0RNM0lDSExvT1hSVjMvUHFRbGtDSWM2b0dXcnI1bG9sSFgv?=
 =?utf-8?B?OTYyRjFobW14Q0FMVkF3SnU1NTMrKytKZ0h5UEFQNGtaVXBoanlMZWw3R0tT?=
 =?utf-8?B?NEhZK2laVWJDTkZZVW5TN0hMeEMrL05UQXdyMjJiVEVMTzAvNFFlci91TzVj?=
 =?utf-8?B?a0JnV3hHUThDZXVKdG90Wk1DZ3dTaVluUndyMlRONi93V010ajJTdmVjWEtI?=
 =?utf-8?B?SHNZMGl1amJqWWJteVlNSDRuSWc3TElYbHpubmpCL3lmWU9uR2FoVjNCSVIx?=
 =?utf-8?B?eTd0NDQ5R0xuOW5Nc2dLRFRBbi91Q2hraE9KM0YrbGhyN042YjQ3Z01CNmJW?=
 =?utf-8?B?SW1Qc1I4QTBkUklYdXc5N0tOR2hmekFReDRTZzZHdGFJdmdJZG5IKzROQlpi?=
 =?utf-8?B?U3VUQXNJOUNwUjRiMHArMCtEcHdVcEd2QmVqSlFKdHpDYTd6Um91bXV4MW0v?=
 =?utf-8?B?KzlONEh1dlpTRzJYcm5wQ1ExT1RiRmxadko5ZklKbUFMZ1A1L21XZzJrYWNH?=
 =?utf-8?B?aUFJMGUrNmt3YmxKK2MrZmFnUUsrdXBJL3A3Z3RtUDVTa1FZTCtrZ0laVGlP?=
 =?utf-8?B?Q1kvVDFyR0ZqWWJoOFNuSG83YVR6ejRXMVM0L2NYNE12MjlPTWFvaUF4ZHgr?=
 =?utf-8?B?c2pUb2ZBZHFtanpHVWZ6UzdWdGloM29oWExpck1MbjhWTi92M3p4TVNvbDdD?=
 =?utf-8?B?UW9Wemg3cFlZVWpGTmNHMU1tSGEvZ05LQkI3NnJ5U2VPNjVDQ1M1MlBMeWRF?=
 =?utf-8?B?UUNiVitxMUhmMnlwUVhzejJBMlI3L2xpTS90WWZ0MWV1b3YrQ01hTDFGM1RX?=
 =?utf-8?B?QUZIbHdKYXN0Z09nblZzVXZKZTdhbEsxZVdmcE9YbE0vSy9uVzBwa01TSWcv?=
 =?utf-8?B?REx3SFZnTWhSY0dFNkkzN3BsZDlmMEN2YVVGTHdEWHVGYW5ZaEJkWmUwQ3pt?=
 =?utf-8?B?cVg4cG83KzY1cDg1WDh0MmRYVS9yZkIvYndxUFg2TFNITm1SYkhTOFBhZjNn?=
 =?utf-8?B?YWNXVEFlRkFHY2NZdDUxcDVZcUtFK1Y0ejVlUlBSc1ZzVzlYYzdvL2xtUWM1?=
 =?utf-8?B?V1JHS1RJYVVEKy8rU2tQTmRyc3hnNVF0eFFKSGpsZllnVHM1a1JtQk5hL29Q?=
 =?utf-8?B?L2JyODNnUWVGSHEwNHBLeHBzNTNNayswT2ZwRkl3VXVJTkVlUTZaTTYvTjRG?=
 =?utf-8?B?MkduNW9ZSjkxaUI2bzRmV1NwUU5TbE9DRkN6ejJxODlHNXZxY1BFWDZ6MGpD?=
 =?utf-8?B?ZUxxOEJpNmxIWERPR0xnZTdzdi9yM0QvNjR5RXEwLzdUc1FIcWl1OWt6RHhq?=
 =?utf-8?B?Tll5cmNKdUxhZjVIb3owNnZiYlYxRC83Ly94MGJOZDVoRFhOT01FZWh1Vjgw?=
 =?utf-8?B?MkhUNWl5eThXTFRuRklsTG9JRGNYQkVYMTlxd1cwYXFldHdXNVIwNmRPU3Zu?=
 =?utf-8?B?Rm1BY0ExRDBhd2cxVlBRbkVOT0EwSFl2MzZMQ3FLMURpdkhWQ001dlpSTW1U?=
 =?utf-8?B?ZmkzbHZpSCtCdXhKNXpiT0dsb3RvZzFTSjVLOFJPS280dFBkd1hZampoaDFo?=
 =?utf-8?B?OERsalJTVDhSSzFBK1d5TWNtVURCeHJJTEJpeVhxalYxQ05GblpicjBucGJT?=
 =?utf-8?B?UENoaG1NK3JUVnM5eGpLaGZzTFk1dFBrbENQWDNidkRSU1U5dXdKNkJUS3BH?=
 =?utf-8?B?aG1Jc3RRaXJZV2t3VGQ5NkpCK0Zkb0ZxS1BWWisvaHBKMVJIUnZ4VG5zQnFi?=
 =?utf-8?B?MzBFK1hlQTdjUmVaVHBPMG1pTHQ5UklUclVxRGFhMmlSSDZnQTB5dEQ5UDJm?=
 =?utf-8?B?VHZWTHVHSkNsOWlMQ3JWdmRIdkQ0L3J2Z1FndkdOUEg3UmNOaXlVTGRiNm96?=
 =?utf-8?B?R1ZRcVFpamhIY3kzMHNvdG1pU2VtcHRmcmh1OXJya3B0WDduWWdQWWFSY1Uw?=
 =?utf-8?B?S2d4b0N3VUo4Q1lFd1FTMlNZMUpTQ0djOTl1Z2x4dUtONCs3WkcrVXFZZ2NJ?=
 =?utf-8?B?ZzJVWG5uY01KOUhUNmtsRGtoWHBpZHJXUnBoZlpVbFlnWG5EWEFsVUFmMXZ5?=
 =?utf-8?B?ajZxb1Q5TGQrbVA1T3VEcmJzdW9XMnRNK3FnVjg3UE4zVTdUVjVISkU3WkVr?=
 =?utf-8?B?b3RDYWJWMWI4Y0hVai9iTFhmdmNUaENnWXZHby82MmxaR3NCbDV6Z1NnaXhm?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DB9BFBC02816C6469CDE4D60778C3904@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3999.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f2de02-d576-4aa7-71fe-08dabe2e2cc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2022 06:31:15.4813
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tfx+tkEwADs5raPLq+PjjYaFw/L0/kB4hot9oG+KYKuatZb/AOenbiVHlo1BOZ7nPzggDIYl0dqssx5KNiGgXb/sGaVtCP6OP8AyR0Ct3Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6532
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gVGh1LCAyMDIyLTExLTAzIGF0IDE3OjMxIC0wNzAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6Cj4g
QXQgcmVnaW9uIGNyZWF0aW9uIHRpbWUgdGhlIG5leHQgcmVnaW9uLWlkIGlzIGF0b21pY2FsbHkg
Y2FjaGVkIHNvIHRoYXQKPiB0aGVyZSBpcyBwcmVkaWN0YWJpbGl0eSBvZiByZWdpb24gZGV2aWNl
IG5hbWVzLiBJZiB0aGF0IHJlZ2lvbiBpcwo+IGRlc3Ryb3llZCBhbmQgdGhlbiBhIG5ldyBvbmUg
aXMgY3JlYXRlZCB0aGUgcmVnaW9uIGlkIGluY3JlbWVudHMuIFRoYXQKPiBlbmRzIHVwIGxvb2tp
bmcgbGlrZSBhIG1lbW9yeSBsZWFrLCBvciBpcyBvdGhlcndpc2Ugc3VycHJpc2luZyB0aGF0Cj4g
aWRlbnRpZmllcnMgcm9sbCBmb3J3YXJkIGV2ZW4gYWZ0ZXIgZGVzdHJveWluZyBhbGwgcHJldmlv
dXNseSBjcmVhdGVkCj4gcmVnaW9ucy4KPiAKPiBUcnkgdG8gcmV1c2UgcmF0aGVyIHRoYW4gZnJl
ZSBvbGQgcmVnaW9uIGlkcyBhdCByZWdpb24gcmVsZWFzZSB0aW1lLgo+IAo+IFdoaWxlIHRoaXMg
Zml4ZXMgYSBjb3NtZXRpYyBpc3N1ZSwgdGhlIG5lZWRsZXNzbHkgYWR2YW5jaW5nIG1lbW9yeQo+
IHJlZ2lvbi1pZCBnaXZlcyB0aGUgYXBwZWFyYW5jZSBvZiBhIG1lbW9yeSBsZWFrLCBoZW5jZSB0
aGUgIkZpeGVzIiB0YWcsCj4gYnV0IG5vICJDYzogc3RhYmxlIiB0YWcuCj4gCj4gQ2M6IEJlbiBX
aWRhd3NreSA8YndpZGF3c2tAa2VybmVsLm9yZz4KPiBDYzogSm9uYXRoYW4gQ2FtZXJvbiA8Sm9u
YXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tPgo+IEZpeGVzOiA3NzlkZDIwY2ZiNTYgKCJjeGwvcmVn
aW9uOiBBZGQgcmVnaW9uIGNyZWF0aW9uIHN1cHBvcnQiKQo+IFNpZ25lZC1vZmYtYnk6IERhbiBX
aWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPgo+IC0tLQo+IMKgZHJpdmVycy9jeGwv
Y29yZS9yZWdpb24uYyB8wqDCoCAyMCArKysrKysrKysrKysrKysrKysrKwo+IMKgMSBmaWxlIGNo
YW5nZWQsIDIwIGluc2VydGlvbnMoKykKCk1ha2VzIHNlbnNlLAoKUmV2aWV3ZWQtYnk6IFZpc2hh
bCBWZXJtYSA8dmlzaGFsLmwudmVybWFAaW50ZWwuY29tPgoKPiAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9jeGwvY29yZS9yZWdpb24uYyBiL2RyaXZlcnMvY3hsL2NvcmUvcmVnaW9uLmMKPiBpbmRl
eCBjMDI1M2RlNzQ5NDUuLmY5YWU1YWQyODRmZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2N4bC9j
b3JlL3JlZ2lvbi5jCj4gKysrIGIvZHJpdmVycy9jeGwvY29yZS9yZWdpb24uYwo+IEBAIC0xNTM0
LDkgKzE1MzQsMjQgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgKnJlZ2lv
bl9ncm91cHNbXSA9IHsKPiDCoAo+IMKgc3RhdGljIHZvaWQgY3hsX3JlZ2lvbl9yZWxlYXNlKHN0
cnVjdCBkZXZpY2UgKmRldikKPiDCoHsKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgY3hsX3Jvb3Rf
ZGVjb2RlciAqY3hscmQgPSB0b19jeGxfcm9vdF9kZWNvZGVyKGRldi0+cGFyZW50KTsKPiDCoMKg
wqDCoMKgwqDCoMKgc3RydWN0IGN4bF9yZWdpb24gKmN4bHIgPSB0b19jeGxfcmVnaW9uKGRldik7
Cj4gK8KgwqDCoMKgwqDCoMKgaW50IGlkID0gYXRvbWljX3JlYWQoJmN4bHJkLT5yZWdpb25faWQp
Owo+ICsKPiArwqDCoMKgwqDCoMKgwqAvKgo+ICvCoMKgwqDCoMKgwqDCoCAqIFRyeSB0byByZXVz
ZSB0aGUgcmVjZW50bHkgaWRsZWQgaWQgcmF0aGVyIHRoYW4gdGhlIGNhY2hlZAo+ICvCoMKgwqDC
oMKgwqDCoCAqIG5leHQgaWQgdG8gcHJldmVudCB0aGUgcmVnaW9uIGlkIHNwYWNlIGZyb20gaW5j
cmVhc2luZwo+ICvCoMKgwqDCoMKgwqDCoCAqIHVubmVjZXNzYXJpbHkuCj4gK8KgwqDCoMKgwqDC
oMKgICovCj4gK8KgwqDCoMKgwqDCoMKgaWYgKGN4bHItPmlkIDwgaWQpCj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGlmIChhdG9taWNfdHJ5X2NtcHhjaGcoJmN4bHJkLT5yZWdpb25f
aWQsICZpZCwgY3hsci0+aWQpKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBtZW1yZWdpb25fZnJlZShpZCk7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnb3RvIG91dDsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoG1lbXJlZ2lvbl9mcmVlKGN4bHIt
PmlkKTsKPiArb3V0Ogo+ICvCoMKgwqDCoMKgwqDCoHB1dF9kZXZpY2UoZGV2LT5wYXJlbnQpOwo+
IMKgwqDCoMKgwqDCoMKgwqBrZnJlZShjeGxyKTsKPiDCoH0KPiDCoAo+IEBAIC0xNTk4LDYgKzE2
MTMsMTEgQEAgc3RhdGljIHN0cnVjdCBjeGxfcmVnaW9uICpjeGxfcmVnaW9uX2FsbG9jKHN0cnVj
dCBjeGxfcm9vdF9kZWNvZGVyICpjeGxyZCwgaW50IGkKPiDCoMKgwqDCoMKgwqDCoMKgZGV2aWNl
X2luaXRpYWxpemUoZGV2KTsKPiDCoMKgwqDCoMKgwqDCoMKgbG9ja2RlcF9zZXRfY2xhc3MoJmRl
di0+bXV0ZXgsICZjeGxfcmVnaW9uX2tleSk7Cj4gwqDCoMKgwqDCoMKgwqDCoGRldi0+cGFyZW50
ID0gJmN4bHJkLT5jeGxzZC5jeGxkLmRldjsKPiArwqDCoMKgwqDCoMKgwqAvKgo+ICvCoMKgwqDC
oMKgwqDCoCAqIEtlZXAgcm9vdCBkZWNvZGVyIHBpbm5lZCB0aHJvdWdoIGN4bF9yZWdpb25fcmVs
ZWFzZSB0byBmaXh1cAo+ICvCoMKgwqDCoMKgwqDCoCAqIHJlZ2lvbiBpZCBhbGxvY2F0aW9ucwo+
ICvCoMKgwqDCoMKgwqDCoCAqLwo+ICvCoMKgwqDCoMKgwqDCoGdldF9kZXZpY2UoZGV2LT5wYXJl
bnQpOwo+IMKgwqDCoMKgwqDCoMKgwqBkZXZpY2Vfc2V0X3BtX25vdF9yZXF1aXJlZChkZXYpOwo+
IMKgwqDCoMKgwqDCoMKgwqBkZXYtPmJ1cyA9ICZjeGxfYnVzX3R5cGU7Cj4gwqDCoMKgwqDCoMKg
wqDCoGRldi0+dHlwZSA9ICZjeGxfcmVnaW9uX3R5cGU7Cj4gCgo=
