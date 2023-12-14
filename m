Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94F02C6AE
	for <linux-cxl@vger.kernel.org>; Thu, 14 Dec 2023 22:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lSd0g8HO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702592834; x=1734128834;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pohJMkRKhS8ph7leMlFgi+xMNGl10xDjIOZM/nf/FV8=;
  b=lSd0g8HOyjrNdbDz8PRtzp+fOpjSH1JcTnlrMDPq2HFpX2sAwCWalcm1
   BhKaTSC/tO6Fx1viYS+/myKVJcMz+vHtd6H8pxodKviI0jrdfW2anHcZc
   yM4q8SD7KQJ6RSO0IVsHUSpoYoJc+tUxOEDMhi6azEIpSacPoqmacTICC
   ItZlvcGEUeBT1wY+WEYs6oGhRJaPd5ImtwMufEPlpEE+D6gggjipggiLD
   nqnosljyYieaVdMKDjT06iiln4PkMfNkp4oyXydcxo0X0Czm73GaRziEq
   kEFwRSWxfPyboGxHtGbZwoEH/GCWGiFZRW8P9IZvrhRvEy62WOI92zDiO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="16749229"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="16749229"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 14:27:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="724225270"
X-IronPort-AV: E=Sophos;i="6.04,276,1695711600"; 
   d="scan'208";a="724225270"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 14:27:12 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 14:27:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 14:27:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 14:27:11 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 14:27:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRWt8uAaM2UtyMH7NqadLB+l8kR/63tXXVcmNt8Vj/19qb/UCdPwTWnM8N2Ur05RYEpQGpWAvaVxqpzG+Xinz9s5FtetshUfQhKp3bQstKoDwrIhL9k3wwQM4q/ezKsNEAi4gC02oyJPkfRJdM/QjN17EXIRxUwIM0Am01nFhcryoA4t7Bysmx61KLir6nwez06zJy5iW5z9Q+jT7o/DtJhBHlxvAVQyoPd7CewZAppsZSAxZtihc76ZJ6sf2PbSv7zdry6lgXbYhG9NXvZXIZlJ6TG2VSchDGsqIooaJNCciMKaucyFtFzyn9GJVA8weFrSWkOm0MkeiaqmYfPBRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDE29qRaorJkAJK+btgsHBOoUd+xFbJzyr6JNNHPDdw=;
 b=UrtBr8WNnlTT+UIfEa7/04z9rD6g/3sg5HN6BJfeVU6D0TyjNbY6OTDAHIt8XgBf2hFr0ZT1vyyIU2kVA3q5CrW1i5N9qlFBR5kCKUBlctsWrz+iC6RuIy03IoB6fyV2L+JJAu/MloYkynp/5wTPMyT1H69enj2nfU0OgLP1nk7i0VnTVx1gz+HA5KwaoqhOBWD3hnlCCmJMK/F0kYclwcMAwFNkjYRW/6UXW+oh7i+kq/50i2y6zSa59BG2zFNkFNvVe8VpygMC+GhPiXbqOCm6RrPysBkWczokl4DBH36hiEMe47x78xto1tIgiy0um0kwX+E1EP82jclp2cPm6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 22:27:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 22:27:09 +0000
Date: Thu, 14 Dec 2023 14:27:06 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>
Subject: Re: [PATCH] cxl: Fix unregister_region() callback parameter
 assignment
Message-ID: <657b813a745a6_17c9712941e@dwillia2-xfh.jf.intel.com.notmuch>
References: <170258123810.952211.3907381447996426480.stgit@djiang5-mobl3>
 <657b72cac2ec9_27c4df29484@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <657b72cac2ec9_27c4df29484@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:303:8d::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 4064e1ca-380c-4376-82d5-08dbfcf3cf72
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9rFsm/UgKfOtQnuAGA18KjAa8XyDCsmRCRlCzXi9Pl4J9bxIGzbU9nsf1JKLEr039hirKuL3InxN7j9rnVFw+LMJ9jUoPl+VPSk6Rl6WleBCdEVdbBfIH9h6TrVQDf7SrJoASC7TsSvZq353alUQQeTUAKCcPxklL4met1K2KdiI//2m6PY7KwKOc6f0q7Nh+niXXR2KCBsOmbWRddIGbNuvOIoA2swIQa9qhzOfKBOEQYAXAhKdzem9n4LgxIrhtv3sMfEUlRn4lCEmSdItOBmNoFNJGlEHqCHJ7rI9kqxVAt+hmnvyuWUoD0ynOhAMqa3Lj0+AkjeSTu6NuUGBryHAY5Q5eZZ9nXS96TWq1rMw41mnjTTbUwzIC0lub5iQ5Ja615SnlJE8Tw8uSoHF0QQPmoacF9qBuRuwb86wP2n3GJjkipje8ewZ02EKpKkxeOnhFW+HD86Iq+XkpveC5htO9ZYRquBQ/2DbLbBgBGV0wNlMq9+X98URNOhYhSiJ5Q6F0rSVQsy+F+luzZXY3g2pCaxY46rNFsjv3Ct2wODx0Hs6N3Iyr3m3f8GV+pyu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(110136005)(66946007)(66556008)(2906002)(5660300002)(82960400001)(316002)(38100700002)(6486002)(66476007)(478600001)(86362001)(26005)(9686003)(6512007)(6666004)(8676002)(4326008)(6506007)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l1pPDKLyAX3jul4gNC43nhrs+lQt/bmA5ofanpkVuCfP/bpjtpmSVQGrw9D8?=
 =?us-ascii?Q?O8fj2MK5BMQcsT309kDvTz7DM//GPScOPUiDWgO8timDyuwqPUu4oc/eVoj/?=
 =?us-ascii?Q?m8B8QUOYl66t7CjePJ0yTup3Pppm2UGF5oErlsd9Czq52QWOSbZPz7DWkgnj?=
 =?us-ascii?Q?MTfXvyGCV8GXVNwNPfEKzNgs3ArhLwagEuCBTaohlqtmimxyWB3FDxl4ZPuE?=
 =?us-ascii?Q?TcH+IWvoH+Vu0XqmP3tFx264jKfs+luENoo5r+D0oyrrOjWXTxc/NQ9jbpQ4?=
 =?us-ascii?Q?QRpgMn0gO/hTdahBZLrAVRNmNSTOX5MniW0LixYW8eJdNCKoGBht3ypJQbu+?=
 =?us-ascii?Q?o8YqbVfaOrz/4AbkmRuQR/aiN8+AuJnoJqxZDh5f/9ehGtivMg4zABy49yhW?=
 =?us-ascii?Q?pSeHgFdYtZ3yJFXIoM4qRYzaQ5bdkhcSQS6xIQDjpJRb34L+fSv+6etN9hTg?=
 =?us-ascii?Q?0sm4Gr2Tuij3mUcBoSLWblZW/EkumvZsPw4auujgZkuWJqaVdPCEJLuAajEG?=
 =?us-ascii?Q?tnYN5AZ07aAgKfqsdm5ea3+WhbGujVCCtbnWpE7fXaFazH3BgNPMR1ddzCj1?=
 =?us-ascii?Q?kS+bIDWWm3wwM0g4vbPV6fwSk+lBPCVBIATjHVxAKjODPaI7mZLZ09qVoEvL?=
 =?us-ascii?Q?tbUrBIwoTP0kbdji1W2GZ02Jwe7LYN/aYhuqXlND8wzznkQPyaTWKjcgztOO?=
 =?us-ascii?Q?7VurZPsJkBwtpTmLKU6KRlAEQ2nDI5yNZJzX4OIutJgoXFQXqRhityb3Lgwn?=
 =?us-ascii?Q?mWflRrgjwa+MQdQ0tU0nbg0VD7IABb6EdgbIpRAPuG25eo/W7H0dvmf+bfbw?=
 =?us-ascii?Q?R3DUldIPQg2C8NLhLSjjpHWdwyjp5Fw5Iz2msj8eZws6PP7Ni+1iTLy3VhzD?=
 =?us-ascii?Q?oSVqHmMQwJyFnuKAOOjXwA7O5A3s2dRevhEthF+GCJlZPqpEfldWkbF44EA5?=
 =?us-ascii?Q?9au52TBe4vPG6oGSDfI67cnIAmrNedD2Md+s3qH12dXM6SKdrq8M8fKvtEeu?=
 =?us-ascii?Q?BPXMZtTRIr5szoyKN9DjvomCK+torQiSc7jSDVhX5R1HbF8Z+YPxhwSeOmqE?=
 =?us-ascii?Q?xochJaDYuwf0Jc0kOhiEecqg4cmp2e4tHg4Im+UvOFV7KhPqbcywUsWq6n3h?=
 =?us-ascii?Q?CtjKAEVBD9NyDsULLuYLObC7MH5LF/z4uII/gi9BQdhck4GIDUR73q5Vg2xx?=
 =?us-ascii?Q?NKteyiseYYyRBCPUcNMHaPwsbnifDC4trRNcipSKqT5fO2M8IxMIK4t53ZrO?=
 =?us-ascii?Q?4sJXmW0BIkTe66e6TwkHP0hQfaXOVg8pFTE9xs2Kxgucekoj6nWqmxaRfOyN?=
 =?us-ascii?Q?xz5E7+W2hXfejTyK/8Dw4XZI5cb5xgLocR0Gh09NKa9ADCJQUZU9k2TnNrG/?=
 =?us-ascii?Q?ycaWd+u3A1x0DhNpipzhdbEdR3GRYwTIBftVqUR7GBYgfO/IKhmgnpgePYry?=
 =?us-ascii?Q?XdYBlQH6MOwFJ2Hoi7jic5jf0/wet1U43rQFw0QTOTOTzEuLdh7neRuchyB5?=
 =?us-ascii?Q?VtsJBsW8/W0EqFjG5z2ZN0XXuRhtiPrWhyE+i0oOSltMzHlE1ovntuvukU8q?=
 =?us-ascii?Q?iKjXHR5tK6CHwsDFwcru4VN8poQzS+PGd6/jej8nGMpC3Z1cuAMroiDDLuvp?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4064e1ca-380c-4376-82d5-08dbfcf3cf72
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 22:27:09.2687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x931SLe19sH2fTPddZ57VynEEQdhNdlGEAnyFyOmRqmuiFye09cgmz0MZfbSCvTNpCnKDDYOm5EJWHSU6efIJ6xKeX5GsvWRJb8U1yMz614=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4914
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Dave Jiang wrote:
> > In devm_cxl_add_region(), devm_add_action_or_reset() is called by passing
> > in unregister_region() with data ptr of 'cxlr'. However, in
> > unregister_region(), the passed in parameter is incorrectly assumed to be
> > a 'struct device' rather than the 'cxlr' pointer. The code has been
> > working because 'struct device' is the first member of 'struct
> > cxl_region'. Issue found by inspection. Fix the assignment so that cxlr is
> > pointing directly to the passed in parameter.
> > 
> > Fixes: 23a22cd1c98b ("cxl/region: Allocate HPA capacity to regions")
> 
> Technically I think the essence of the bug existed in 
> 
> Fixes: 779dd20cfb56 ("cxl/region: Add region creation support") 

Agree, that's the correct Fixes: line, but I am also debating dropping
Fixes because unless the definition of 'struct cxl_region' is changed
there is no problem in practice. So a Fixes line will generate
unncessary backport thrash. I'll just change it to be mentioned as the
originator of thinko.
