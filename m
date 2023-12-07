Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ez8ZlgTg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A381734
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 14:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701987608; x=1733523608;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rZBtqNjSL+dF03/yWIi7EaKh0eKtfZIMQOml9CvNJXw=;
  b=ez8ZlgTgdfhMriEHGQml4hUdq7wBN4Ud2Pj9UfDUDHOwwEC6ws8cploi
   R8fmsogi6tfwjXXECTZqZ8+oMOhTLqKC08n5R+WSQ44REOY/8vvqYtayV
   IWQ1SeoAr5nLPWzUURGyXv3K0z5gJ4como8vVAbYCsvpH1chAQQFEaUhh
   0rmTuIm6SZnekDZwMiURPpBCvIa8ylr55HfX0ysS2KcZXFUd+eZuYEpkD
   BeuPjcfDYk6JHnHAd2BuZbX/PMpPa4BWD/r9oc+wiNv39xrXJH8wcvYR8
   cyd2ZDxxWBtL9iCCQepRz5fKkBTcn1L1f16Ba2k8nwnEbuXbZtjteQC7o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1394556"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="1394556"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 14:20:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="889890387"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="889890387"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 14:20:06 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 14:20:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 14:20:05 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 14:20:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 14:20:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J4RCQ8EHbTRjOs3R/VrurWBgrfVBhLhJH4YziWyPMx8F73OAVRTIkaS0aBZM5+KQHkjy/q2Llxwy/BHYeI+mGBzYnZ/KYMrmjXIWlfM+xxJxA9l3DZe3BFiemDYfK+CUKc54/AkD4mDX92WWItaGolKsLYF5DDs5ohfJ3V87MujAQnaosreFZfHO+OGf/tHyNcvrmtVZSe3aVrq9bUu49Kazi0c8Cfc2GPkPHV9CPABe8i5gRpjevPOLSg4W9cwnnfexY/JiQCjQDkGMVIcVH/MelR8Bia1rMFTTuxWm0ihrBpX4P4U7aTo9aXeRyl2oqyB6quwzoSIITm064wYyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rZBtqNjSL+dF03/yWIi7EaKh0eKtfZIMQOml9CvNJXw=;
 b=OxCW+4GR882KJp5o7ZcPRXSyvui31GdIZB4oaEL9XKBtH3ba7LRy1XiwDWuZMJcFf5rKE4kTtwbiZX1qSVZ1nIJgtHT/xwCie0mYLkWKQdNvjHFDYjXGE/GHc7aVIpQUswprBH0DDM5wX1EJugyMtBdACwSgWDe6rF/n2P/BYGBVeC+0oOBqwMk2whvReGnxh9MAn+u/mb4NAnjU/s5i+w/HEZf/B9qECGhb9N+X3qaQgUHp0cbkWhsi+YxYIfVC+iK+5W8mgX/mzTJaM9SW2HgnMWr3Niw9VOOZeRjKLycnh+JNPxBbsQOkhfW7jSRBYg8900kvN7QSBpso2Ra1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4783.namprd11.prod.outlook.com (2603:10b6:a03:2af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:20:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.025; Thu, 7 Dec 2023
 22:20:03 +0000
Date: Thu, 7 Dec 2023 14:20:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>, <linux-cxl@vger.kernel.org>
CC: Li Zhijian <lizhijian@fujitsu.com>
Subject: RE: [ndctl PATCH] test/security.sh: test keyctl before excuting
Message-ID: <657245118201e_45e01294fb@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231117083947.2211323-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231117083947.2211323-1-lizhijian@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:303:8e::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4783:EE_
X-MS-Office365-Filtering-Correlation-Id: fce134fa-1206-4da8-5d94-08dbf772a8d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9yhKFSKp+dD1mxs48Uc0IXCI49lfdite926hcyCgRP5hGXfUDrasEU2kk71VrTNZcK6gHGWrWUhR38IOeSqeFy26rOpU5FRlks9qUixrwG9r/+F/KhIUXXpexYu5FT8WY7zjk8kObuwyjxBaOndwETITBuKtePeEmEFai0o6rvbn9O/RC4W1W0HM/ezYPTcqbv3E2zNp1P4AuHJwQBG1N+znsEiBijam8Kcb/x/Swf8pp7NaW8SokdrMCsP4siNbm91oAIEuZg6QiEvmCE3kpIlxeeGQAbmgpocTPQ/SSrL/4oeIcdF4bMbobSaoG/NbkpL9474hLJ2ZeUPzdi3c32gdvJS3EN9jTMI1AeKyXzXW32+C71YVW1BTPrMCJPvSD5+/I9cj235MFyUdKQHqTY+qRDx6NnsuPgTselhPLa9vuZLK0GwI8NLHJY5G9WO9muV2EwOqoHobTfAuwV15AtVwhy7vrC9TV1Raf02+N1DkVPL0O63FT8ALVgyMGgy7HyWRC6YcM7hohkrPQlmWKctGZxQIv1NiRvOasKxyQH+Y1owmufD/ddfYzoIfWWg/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4326008)(2906002)(8676002)(8936002)(558084003)(86362001)(5660300002)(41300700001)(82960400001)(6512007)(9686003)(6506007)(26005)(38100700002)(66556008)(66476007)(66946007)(6486002)(478600001)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?92J/SeDkOoOIwjNvceKgqiDF0HvvMz/pV7kb6/kOvH47pu5n+6qRNjI5din4?=
 =?us-ascii?Q?0CNLHRlgb0JMANW8Nd1wkBW+lrJq/wgNKYkIQEQXTRi93DkyJyv84RdLx/1T?=
 =?us-ascii?Q?iOsPBGHT4yzJ0cjsW9Ts07d7UFtoQs3isNMQ/BGJ/BCXaCtDTEpR4JlBIp/B?=
 =?us-ascii?Q?sjENwhEHAfIRleLcYyFALavsovHUIZKWyZ9qhF/Wqs+cMW6FgGjgbyqaxwkO?=
 =?us-ascii?Q?prPD1xDnbmEE16s6uRyZDQmaNCLhk1ZCvezvK7iz3NXpuJwI5XA6qBtfwgK9?=
 =?us-ascii?Q?v88CIEom9endCWP3eBBVlgwAK4HhIMoEVNjS4I27RIcNh3PxHOQmPJ0A1ete?=
 =?us-ascii?Q?Ysc2I0SAxvSC0SQs2rxJhiFTZcCbnm/05m+8o4rcx0ZRLnQgnQl5y32EJOYP?=
 =?us-ascii?Q?4v3wPp5g+ZkIBCe406JEM8ugL9wq9Hpug3OC3CRj8v8yLo4cgpmTt52dXxyZ?=
 =?us-ascii?Q?QRPSWWpLyxP9zPuVc0b/BnXaUX5OT97FjuRKsrRAOu7T+sRzpskdhfoQDRbt?=
 =?us-ascii?Q?pWNfFpJrRCe1I4uUzEkJJYaRCV07l4xgUll82Vw7NW3ysflNzZa0SGmMBlkG?=
 =?us-ascii?Q?IMJwjRNDBP3zcWsc0/GsDfxSwN+UpSnA5it+sNuwzSTQoOj2HHEWyelbPSIz?=
 =?us-ascii?Q?ujUXGZDwPC9Qndk/BCmxnGL2ri7xlaPL6ffvTPX6FP5gDN8uiIwnEja84zy+?=
 =?us-ascii?Q?76d0s88ZUQC5OuTU0Xo7EOv5wnUMFifsnC0nYLfnYj11ighAQ12F7jbDsV1u?=
 =?us-ascii?Q?5qihrTvQ4em3XNWV78mVpZ7fxCHx/N/CocNnKJtiWZTHlfcHcLnRoHhxE7Nm?=
 =?us-ascii?Q?S+JELb1OiBTpUDmSv1Gd767fAfQ3QduGDJ+BjAZ519Hkcut1BGiD0CJzBCS/?=
 =?us-ascii?Q?xJs68pzlrc37eX+H8n9yPB2WJqItOe721N2SFS0zU3BXZkEbF/fmEoH8KpSq?=
 =?us-ascii?Q?L8Be0lk0nkubrNYJavSFZQevsRtUGtajQYUiuZliLsy5NzQ0sqBAm765mYC+?=
 =?us-ascii?Q?XOkmLFpPbO4+FdfyLoQgyQEcoNmLReor1xq8bmr3WC3rcOkYnwjw8knidg7g?=
 =?us-ascii?Q?bqM6YyN6xS4Q2n3IL+JSgMuCSumYKeuHaYFqJ7qMdpjdv2aVPJ2tBf4USA3I?=
 =?us-ascii?Q?EQJZFXqbigSj2mLa5Xb0MkTW/Nz8b7CtwcDBP3TFh8NHwaHkUOEDtwB3yNI9?=
 =?us-ascii?Q?+fe1zXcDH/NoHCWGCCm6VxEUhAClnf9BD0A5Jeg/+3tutQHUwlQGhZnhwQ4E?=
 =?us-ascii?Q?BiOrkH7XFXqVOB4J6FkvVzRat7q+SZ61I7Fs25LY4qv1uumX4+egLOuhVp6p?=
 =?us-ascii?Q?adK4UxZaBBzI4MlkQ80Gku+nf4eGy7bshJ+Ke48uuLFF1jTi3Fwzc7IYqk3C?=
 =?us-ascii?Q?t0QMbYjKfqE2UgjkBfOz4plSAzki8TnAB7LF8kx4NmiV3SzyvILNKD2zAYyj?=
 =?us-ascii?Q?wGYHvam2qRIyJNt6GhnZh4i2UZJxMg1nuBEq5DdmddBymt/t+tPRIzYinK3p?=
 =?us-ascii?Q?PLXpKX+hHfavhEf/jE6K3rwHmGQQmuhrtdpGTXNbpHx+QpOd8XN+f2cMPArN?=
 =?us-ascii?Q?J+jdbqmdOQFY5EyFR3kpLrNaXafR8qnACIb7SMOpkcc4FR1Ud4Th75D6hniP?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fce134fa-1206-4da8-5d94-08dbf772a8d4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:20:03.5940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjByj/2HFU87tX9NheE4+a8hxM+xCvvfMA3FRDaywTR+a4Dj9XAdY3bG8D1267l0jvdcMgIJ/kWkaS2pSPgp2R5Nd7VLGQxTHRQ7+EUyBd0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4783
X-OriginatorOrg: intel.com

Li Zhijian wrote:
> test keyctl command before executing

The "why" is missing here. Yes, someone can read the patch and go read
the code to see that this is probably a good idea. But what is the
effect of not doing this? Doesn't the existing "trap" result in the same
skipping of the test?
