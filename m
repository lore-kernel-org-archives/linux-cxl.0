Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CA5C77B7F
	for <linux-cxl@archiver.kernel.org>; Mon,  8 May 2023 18:39:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjEHSjs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 8 May 2023 14:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjEHSjn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 8 May 2023 14:39:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26E6259E9
        for <linux-cxl@vger.kernel.org>; Mon,  8 May 2023 11:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683571183; x=1715107183;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=R0m8ZAhLKamUISbzVtesyI5cFR0RyLxviFaD/kchsPI=;
  b=Rp+tLxT9PvYrNrmOpKxYjnrs238ZHTQAC5/JRfW81m5J2DM6M0KcBEaE
   4IVXerIw7ak1wvRMtH6Nftok2LFjgagVIXLfZDly4CrPJU/VJkFfReAvk
   6knDZ4VvXHMMIqdh5Ln+Cd6USVU0tuAhGIjFATCP+yk9EH3iCvIZZ2w3F
   5ZvNAS3pDJqQ83TRVGIfZuk/zdJHo9AKpk525KlHRhwwa/4wiZenhzd1u
   L4R+8c9NIOrr/z66mLxQIWj2Sv4V3wGeeOgKNQRlpE8+cgdmLOtnmxqc4
   AxmYqW12lZ/IJoAUxDYkmGQ+i4dFlN2R0LKY99/f01rdRKt4tj5qPS4Rf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="348554220"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="348554220"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2023 11:39:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10704"; a="648996611"
X-IronPort-AV: E=Sophos;i="5.99,259,1677571200"; 
   d="scan'208";a="648996611"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 08 May 2023 11:39:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 11:39:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 8 May 2023 11:39:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 8 May 2023 11:39:41 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 8 May 2023 11:39:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sth0Q/rp4gwERYXTf+XGuvA6Jsc8/JDCnLH4V7F95Dotr7U3vLB0RLZsvAse85CJk/vL//S1nAAt+YAkITcXx/S6yYDKwzAkGhYU+o0BZx1jDLE9vsfKHBf+h617Xfrad31QhaIeHjS8eX1IAVxTxrOcy6stDdByP6IhW69azX2G64GQGzSL3SLJPNaumsxITwdJuhqcxuwF0Cc4jdb+2JlZkZFZzgUDpjC2Ka5/GERB3C6ScJ3AawJ6bbsX6C2H12nSmTxBsUvF3ZrVSjxjwA3lsznUMmY7jqzEawU5dc8C/tU6vC71bmwxr+PFxrjp2cts8IioJ1q3tibFHYkmFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0m8ZAhLKamUISbzVtesyI5cFR0RyLxviFaD/kchsPI=;
 b=PtiR8oTiR15yJuEV5vWCo45vlyPGWsePVC4eerww8sp4x+pL3F3bLtuJ8eZZuiLiitbP9Zo01Vw/LWGCYurPVq3YsF610YCZspUHPACuJ2moG77gDueoW3YPijbHmFjbuyYFBkK9nUwSv1DYzXMULlXKWEAfPMzDrLN+sWC1BgX2SD79dhgnnHoNSeBS3rQDFUbDXhlesojMWA2EZNEOe7UoI2SE/QXDLFWrUjyMxdrrM8Mb0a3pOYuJBMyahoYeG1eZAhosQPhT7jrVfzP/XLGiAfs5ieeE8aEsOb3osNx8q/v5t2yjJUiX55Ja9QIiMDSrb1OdYz5t58a4ISuyAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by SA3PR11MB7583.namprd11.prod.outlook.com (2603:10b6:806:306::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.22; Mon, 8 May
 2023 18:39:40 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c1d2:a32a:f7ef:1803]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c1d2:a32a:f7ef:1803%7]) with mapi id 15.20.6363.032; Mon, 8 May 2023
 18:39:39 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "im, junhyeok" <junhyeok.im@samsung.com>
CC:     "Williams, Dan J" <dan.j.williams@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: [ndctl 0/3] Support for inject poison
Thread-Topic: [ndctl 0/3] Support for inject poison
Thread-Index: AQHZROeuM39+YIgZgUW22byHVjvc2a9RLxMA
Date:   Mon, 8 May 2023 18:39:39 +0000
Message-ID: <eb792ae37ebe68dee94d7445084ff99855f0268f.camel@intel.com>
References: <CGME20230220045604epcas2p3bc0b1fb688c48ec0b8ae2512adba3513@epcas2p3.samsung.com>
         <20230220045709.94027-1-junhyeok.im@samsung.com>
In-Reply-To: <20230220045709.94027-1-junhyeok.im@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.1 (3.48.1-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|SA3PR11MB7583:EE_
x-ms-office365-filtering-correlation-id: 01806d94-04c7-45e1-03e7-08db4ff39503
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ig+NW1rlIJnvEAeowxheSRzSnYBnYEoGLPaS1Lnn1kmkeEuQe5FPixqnhnVXtbtFN1Z62cDOsHFbWYax6+Sxx+05+bE8DPFcTxgvAdKkD83KYAT4PTDTN0t+qHHtpyyCeRpVe+nE1sokdhp6dhrJalfjxL0DihgNmtBlz3tVgbpt0IytCAvfsUHHfm58soPQnKM9SxaQmbDrGIQXv589VAUk6+IuKgZramSjyEweB6qLL5bcnvN00SAmhp1tf1yWvl/aZbivBoQFmMrJ7UtGTJY8xpt4kUvh7p4aTNpMvfMr4YXtc83H8W03juMo6/iRqp1nFrNV7iyhzTmk4WxnsVYPda+GvHqKqIjUnoAqopGzocniQ0s56+GTA6k2fRX5KEVzzL6hF8zNlQ2Ivn/VF2Iwq4Su058YAHAmdPZdHi+rExPKfzat8cK8MIr8SZYxUrBoR2odnMrIrh8ybo2I+1Kde10iSmu5mJuBT/1at0cx7d6TyK8n5rTcGy/8HeAMJI9Bd6Ct+XouX5wE0NZ8gDKjlEsm/+mryB4OLm/lGr0lai029B4YbWc/fPvM1jpSa0BhuByNshtosgdR+isiwl+dfKBbVTWf9gHBkR1AIRCGKJ/JyC6RuUEXwYblkLSs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(346002)(136003)(396003)(451199021)(38100700002)(66946007)(38070700005)(316002)(76116006)(4326008)(6486002)(82960400001)(41300700001)(71200400001)(478600001)(54906003)(66446008)(122000001)(110136005)(66476007)(91956017)(66556008)(64756008)(86362001)(8936002)(8676002)(5660300002)(83380400001)(26005)(107886003)(6506007)(6512007)(186003)(2616005)(2906002)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWJ0RE9XcXhWQmJ2WC85Nk9XZHFhQ2lCRy9FYlBTc3BKdzN6Z1YrdDdBeDc1?=
 =?utf-8?B?OWZEekpLZStkTkFWR0xKMEpoeXhabkZMLzVlbWw0bTA3MHYxRkxZNXRJMnRZ?=
 =?utf-8?B?Y0dZSjNtWnhhQVRZbmx3Z1NRR1BSWVZRUXpjd2lXNldBb3JBOFFrNVp0cFN2?=
 =?utf-8?B?SE1ndEZHY1Ftd1l1elpnTksvTVlFSlAzdGs3Y0VXQXFad1RFS3M1cDRNakxz?=
 =?utf-8?B?c2Z0TG5DTmE3eWtGM1FhRmFHbUdzb2l0d21ldHRDOVRYc2U0dXhMbVFEQUxR?=
 =?utf-8?B?VUI4Z0R3ck1GSmVHUGhGWTlTeW1UQUVYOEFTNTZkcWtUTzZEVFlXK0ZOTTQ0?=
 =?utf-8?B?QmVuT3hUVHBhYW83eTJSWnNxK0ZyWHYwemNWWEQ1ZzFQQU00ZWtuaTBzZlYz?=
 =?utf-8?B?Mk04YW9CempaRDMzVWJOZ1lKenJkNHFmNUN5VmJ2YWNCL050cHZqWlhTUC9t?=
 =?utf-8?B?SHF5c2pxTVJKZVZnVzF6M2xQTkMyS21PTnBWMS9vRVhwM1V0S2VLajI1Y0R5?=
 =?utf-8?B?UmJUTGQ1TGw0ZXdXaEtjZlVRL0d5YSt5Y09BRS9JTWMxeHQ3eERHTm1yR29m?=
 =?utf-8?B?RW1PWkdRb1RCYmRyN0hFSERHR1hXNm42cjd6amtGbzNsanA2WWhBNHoxWFV0?=
 =?utf-8?B?bzZkVDExZnZrVndXT2dmUDRoZkhRYzRma3BGZnVJRkZSMTFON3QzblVWTjdw?=
 =?utf-8?B?Z1FjbGplSnZ5ajFjQS9VZUdwTDB4OHU5Vi95WU0rN2l6bDh4SUV5U2o0VjJC?=
 =?utf-8?B?ZmdlQ0NkS3ZhY2NoTGdTbDJnVmY2ZlpabGdEMTRvUEFXcW10RWhMM0V3aGFW?=
 =?utf-8?B?b0xjVkF6VWdQMWl4Y05lNmhBQ01QMTA4cTVLRkJWUVBWWGM1YzJiczdlK0sr?=
 =?utf-8?B?VUF6UmJvSWNJSm5zd3RMZHdRbk1NZzU2ZjZQd2gvMjgwSkdRODcrMlhZb2w2?=
 =?utf-8?B?K0QwQ29za0IzeVd0Q3M4L21LbUMrMlpzTjFPWWNXZXFnNWJEeG5vVFp5eVRl?=
 =?utf-8?B?ZzdFZWFqOSs4cTdpL2VUQ21sSEZCMUZrdjEwblozNW53WFpoVVZYZWFyS1dW?=
 =?utf-8?B?bGlNdDh1MlRKMzNHaHZuVS9uS2R0T1Bqc0FLZzNYakkrUy9rLzNOaE1HaDdq?=
 =?utf-8?B?VmpmQVdaT1lsa1RiZ3B1Q0R1eDk4VjI1c1FNMy9vNXp5aUM1T0ZuNnNUcXhC?=
 =?utf-8?B?T0UvcGU0Z3oyMDZOU3pWd1hIckxZTXNoMnA2NDEwMmtUZm51U1V5QkRrbkpU?=
 =?utf-8?B?b2RJblBSU2kxS25oRlU3eVo0SWRNYjl0ZGwrVFA0TFduekhOd0pwZGFIKzFB?=
 =?utf-8?B?dGZZdGpLVFdkUDYxWUNOSTdTblF3anYrdmFXbGpWQnl3NEM5MXluRnhCcmlW?=
 =?utf-8?B?bFJXVnR0WTVZTUhtSThWVXd3QnZEcXNkVHJma3lVSWpxcnQyajVXRWNoUHps?=
 =?utf-8?B?bFIxRS9DSm1rU1o2dGVTb0lLNzcvRHBjL0NpVzJ6K3h5VjliOGJsNStXdEZv?=
 =?utf-8?B?RC9tMWdWVnRFdnFBR3FGRUZWUkJrNDVPVXNtSVpWS25sVXMyV20wb1E4WHRy?=
 =?utf-8?B?bTUvY3hHeXhtblc3N0NnQUw1ZTIzWTJxVmM5WWI1b1hCeVhKOFZmQTBGV0NS?=
 =?utf-8?B?a3RXYjhDV2Jta2xqWW5jd2I3V05lRmprVEIwZS9VdWprV3BrWEpONjBaS25s?=
 =?utf-8?B?SXYzWlpLeDVyUG0wRXdMMjdEYTJJWVpEblprU2NwbzViWTZMWFJNclMvdUtn?=
 =?utf-8?B?ZW8vK0xPd2RXZW90UjlNR0hCZHJ0TXMyN0FVdllqSjhCMFpINE5xeFp6ei9r?=
 =?utf-8?B?UFoyNEhBMnhuNjVmNXNKcDEyS0FHNnRjN2ZFUzd6Q2ZnK2oxbXdRSzFrT1RP?=
 =?utf-8?B?bCtNSVFMQnNiRHFHbkRrWVRJc0NMNXdwOS9STGRRNUVVOERVZGxnV1hpdDVT?=
 =?utf-8?B?QWFVUDgxOWZWc0dyRG9LZnRQRTBQa3hZaENqbVp4RHJ4ZktlNHUyS3phT29N?=
 =?utf-8?B?OEN4ZEpib0xqcEM2WjViZW5IRXJOWUtUQm1EU2F1ZkQvMHJZRTFic1QwS09I?=
 =?utf-8?B?N3VjRGZha3Zub3hiNnpRQ284Qm1jYmJYRHRMOFB3U0ozRERUVHRJZmxwby84?=
 =?utf-8?B?T2xreCt0VUtZOVJ1OWgwMXJiZk9oREhQVlE5cmJ0ZVpOVWkveWlmYy9DbXNo?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24D0EC8CD1B0AD4D89151072F8C42090@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01806d94-04c7-45e1-03e7-08db4ff39503
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 18:39:39.8565
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: otC+ZQc2RtgVopi9LwP3Y+OSIIw1n22lbyPnHCJFvNbQ2zJQ4HvkfRv1+zLp7v1MyHQvlvIiXyYUYT12Z6eQNqez4rvwNgJ8EpQWvWI12WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7583
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

T24gTW9uLCAyMDIzLTAyLTIwIGF0IDEzOjU3ICswOTAwLCBKdW5oeWVvayBJbSB3cm90ZToKPiBU
aGlzIHNlcmllcyBhZGRzIG5ldyBhYmlsaXR5IHRvIGluamVjdCBwb2lzb24sIGluY2x1ZGluZyBs
aWJyYXJ5IHVwZGF0ZQo+IGFuZCBuZXcgY29tbWFuZCBpbnRlcmZhY2UoaW5qZWN0LXBvaXNvbiku
CgpIaSBKdW5oeWVvaywKCldpdGggdGhlIG5vdyBxdWV1ZWQgZm9yIHRoZSA2LjQga2VybmVsLCB0
aGUgdXNlcnNwYWNlIHNpZGUgb2YgdGhpcyBjYW4KYWxzbyB0YXJnZXQgdGhlIG5leHQgbmRjdGwg
cmVsZWFzZSwgdjc4LgoKSSBzZWUgdGhlc2UgcGF0Y2hlcyB3aWxsIGF0IGxlYXN0IG5lZWQgYSBi
aXQgb2YgcmV3b3JrIHRvIG1vdmUgZnJvbSB0aGUKc3lzZnMgaW50ZXJmYWNlIHRvIHRoZSBuZXcg
ZGVidWdmcyBpbnRlcmZhY2UuCgpEaWQgeW91IGhhdmUgYSBuZXcgcmV2aXNpb24gb2YgdGhlc2Ug
aW4gcHJvZ3Jlc3M/Cgo+IAo+IEp1bmh5ZW9rIEltICgzKToKPiDCoCBsaWJjeGw6IGFkZCBtZW1k
ZXYgaW5qZWN0IHBvaXNvbiBzdXBwb3J0Cj4gwqAgY3hsOiBhZGQgaW5qZWN0LXBvaXNvbiBjb21t
YW5kIHRvIGN4bCB0b29sCj4gwqAgRG9jdW1lbnRhdGlvbjogYWRkIG1hbiBwYWdlIGRvY3VtZW50
YXRpb24gZm9yIGluamVjdC1wb2lzb24KPiAKPiDCoERvY3VtZW50YXRpb24vY3hsL2N4bC1pbmpl
Y3QtcG9pc29uLnR4dCB8IDQyICsrKysrKysrKysrKysrKysrKysrCj4gwqBEb2N1bWVudGF0aW9u
L2N4bC9saWIvbGliY3hsLnR4dMKgwqDCoMKgwqDCoMKgIHzCoCA0ICsrCj4gwqBEb2N1bWVudGF0
aW9uL2N4bC9tZXNvbi5idWlsZMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsKPiDCoGN4bC9i
dWlsdGluLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHzCoCAxICsKPiDCoGN4bC9jeGwuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMSArCj4gwqBjeGwvbGliL2xpYmN4bC5j
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDI2ICsrKysr
KysrKysrKwo+IMKgY3hsL2xpYi9saWJjeGwuc3ltwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHzCoCA1ICsrKwo+IMKgY3hsL2xpYmN4bC5owqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsKPiDCoGN4bC9t
ZW1kZXYuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8IDUzICsrKysrKysrKysrKysrKysrKysrKysrLS0KPiDCoDkgZmlsZXMgY2hhbmdlZCwg
MTMxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4gwqBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9jeGwvY3hsLWluamVjdC1wb2lzb24udHh0Cj4gCj4gCj4gYmFzZS1jb21t
aXQ6IGE4OGJkY2ZiNDIwMmM3M2FhZGZlZTZmODNjNTUwMmViNTEyMWNiZDkKCg==
