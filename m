Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142D482F5
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707158468; cv=fail; b=FDlUekh6nYmGSlfpwxDb6oA2M2BO1Cx1YeWjRyyvb4MZYT2KFmr6A2+WND76c/qktPnmm+DbXnVbYWquFs7FsCiNOEFkAAutdSqjiFcVkipYA2CDAvAyo37i5E5RfAYesNjarL+ypLFTsPtUUyXIZ5DcggFsTIE7ezAyeGfUneA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707158468; c=relaxed/simple;
	bh=cWvi3gsda/DUDzvn2ms3PzKFR4fGrPjve1YYoXv54os=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HOBP5CLgqXZen9Q7OidN8U+rMzwesR3naKydFJsXJi1lyKbnRVhcbSOObQF1yzsLXao3ReBcnjQlADnKfVpW+SxthImAyvA0yWQEOqw+zjn6/4Zniw0uupHUI/JxgXGMU2nc05euA+rc7Z2Ilpjc66t3Q7psAs627jPmC/XIHIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ETgWvx8+; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETgWvx8+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707158467; x=1738694467;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=cWvi3gsda/DUDzvn2ms3PzKFR4fGrPjve1YYoXv54os=;
  b=ETgWvx8+ulyS9BCroYQAABEJjHVxvoy9/nW20DmjC3+cbx8en2BsIsGh
   0LwmNvXPDct8OG7NOXjHbG1Ze8UM0SR4Lr/w6mTZ7XieTRJzO+Fl2ZtYi
   oZgyCLEAuQZYZs2af5FytDjAuB5p+Fyqod7OwXe5HSdrlsQeaBcBk92UP
   pdbdpdct/KX+5UnddudxD4F2rUjjYX2mECvmuC8iYs1gRdlHfJSMwu6jQ
   wDoH59f3iOkdRIrcz5W5oOgPBtg3vcMaBXDuQOA5zKjY/KUO87Zme50Hn
   ZWnyhU0Bo5dJVyfdNK2Mc5zPkkXJ9b+5PFT38Huz0yG/5UwOzLZcumUiY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="737149"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="737149"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:41:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5541406"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 10:41:06 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 10:41:04 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 10:41:04 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 10:41:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0mjDMorGmz9alC1gC4sImb7adQXUjidF5qPCpzOiInMqtS/JgVbSBKj+llYtv6yh1pkfTvrBxIRmV0VTr77JgNuEvPEXKVAY1sltbn2qFL6m3Uda33cipEkdwI+PB3ZSWOtj4qh3H+d4rPxvQdvYYmZrDHImnFeOz/SOaxq6FwO/rpbZyeFc+IXpGjKFiwHszkjbfunEv2lc/s4T/C3HiHv8kdfzFa802IUp/Q8DgF9P30kMj4x/RSf8+m3nM8DEui9tbRjAidlYl1QmNw3/saLhrrlUqaPprqFiCAMqMUDarsMkosFeOaMV9x6fCETKZQZ+hy2n4YTmJiOkyiihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSDnPLC0OFgyUFqqe4xWFlcE643Bs/XSau14tWqurIk=;
 b=PcPTifEVdS9OQ6gqSFFLU3ctzH1cVbVHzGwjHQGrU1O2jAqst77Y4gHglL7lYG3qQUTHWQLBidSTWIwkxMVE9kWPvXsVtd1vxikgjy17YKV65ZSiaxGGwf2A4F8qlS1ZLYXS8qPIbWCA4VSGMf0thzNm8rvxfdC26aYtsrNwqbmC4jPF4vWmiBDdTeIJOlJJWWu+XyXg4tt1HmS7uLUgmElhc2spYB9tE8DMBoeaMnitlspkVDBfT56Jqoz46U27xStxlub4NxWCczHlxVgdUZeA+LQr1rsS7+QiYdQsj2KBAH9Yk+9MC/5h0Oj2Iba8eKDBFFzMHJq5xWWm9z3PnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5313.namprd11.prod.outlook.com (2603:10b6:610:bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Mon, 5 Feb
 2024 18:41:01 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 18:41:01 +0000
Date: Mon, 5 Feb 2024 10:40:58 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Wonjae Lee <wj28.lee@samsung.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	KyungSan Kim <ks0204.kim@samsung.com>, Hojin Nam <hj96.nam@samsung.com>
Subject: Re: [PATCH v3 1/3] cxl: Change 'struct cxl_memdev_state' *_perf_list
 to single 'struct cxl_dpa_perf'
Message-ID: <65c12bba9a7ed_4e7f5294c3@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240201214731.1297389-1-dave.jiang@intel.com>
 <CGME20240201214822epcas2p3062089e1281f483fb26eea3c80a71475@epcms2p3>
 <20240202042140epcms2p3c6f0708e85374e958df2f58416dde705@epcms2p3>
 <65bc7d62d42e5_65b26294dc@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <fe311247-ba59-4e42-8e7a-e49abfb9cc3d@intel.com>
 <d9e09c9b-837b-41ed-a0a5-be740ea5481e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d9e09c9b-837b-41ed-a0a5-be740ea5481e@intel.com>
X-ClientProxiedBy: MW4PR04CA0252.namprd04.prod.outlook.com
 (2603:10b6:303:88::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5313:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ea7ea84-ba18-4ff6-238f-08dc267a003b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OHNWGohHlkuX5ci6goFKm4gQQdfDxR12AM8oVIH2NujrYJh3mEEfjfoqZTGIQyIy0zStyrL7SKNFQ5kXqw0EbNXOgcHoAZ9fzxxqGwgAkpohpiAl7eUAan9JVWkxnHZOGUnyz3LLZqRoU9Rq2E+PkGsNtBsBkr2bJGZRKg0yI7GCcUvJlOSkwsW3djkI6M7qdV+bN0dLbrOtWYRuAg4DvFgctr2a7xAls8MgVxSyfbIkOx2L6wCBuyWv015qoOEW1oHVmS2IJ59SSRHgEuTsl07f7f5VXXcy7Qseb6obUqPps5GcUfyugEKR+hELLbWd3TK1rz1q6Y1je4xujEbsmVwN42F/4Vp4S73fwXetAHpmPJiXeyvABz5XcUZKDFEadMzo/29eUMMwj2ZL3nSSzCXEBbOaa+94qL6IKrGdNBsMQDKDxtGRCaC6wX9Ci7wXCzKNe3ebwo+hcAAcGkPK+aLqEaKNEApiyfGK4Lzs59/Yiz1edtTRIXw0JPbDEG8l8ZYnbgAuxrnF2ongQ+LmOLylPH8PjF3gBsUM9xtczV2th/y67h6vL2SfbP3KBPdB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(110136005)(54906003)(66556008)(66476007)(66946007)(316002)(2906002)(5660300002)(4744005)(8676002)(8936002)(4326008)(82960400001)(38100700002)(6506007)(6666004)(6512007)(9686003)(478600001)(6486002)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x9pr1a+eHi7+DfVHpvoepzRjylUu7HeyPUSwKTUtqM1G2+HAXI8RcDzXGZXq?=
 =?us-ascii?Q?a82B022MokThlBrtZeDeqEW2glvRbUC/q4JJpGSrpxtrR6Sq+BO1oy2Agdpn?=
 =?us-ascii?Q?shOhY1a1BPHsNUf6ccpJt5ZLinjk9GeRVP7fuOmbfb66BmmpCVhkb94dz8+I?=
 =?us-ascii?Q?90sf3LnE0u9ns4ClRPKrXzgakLUsPthVHe0JTZw2BzMDRIYT2mlhHtMQCRfO?=
 =?us-ascii?Q?siuxLZsHdgZxs1gMhGiEqhqEjUbZ5wSAWMeDzkppLzmFoRVedLh5zbnLZZkQ?=
 =?us-ascii?Q?oMD/ktB64oaltpQU+Va2EFF3roPbKAcCf4q6aEfvvFG1PRW8Qys7A86N6Mc2?=
 =?us-ascii?Q?5pXnzzPVE+PH/1qbEe2MIjNMwTaP1gtPu2Y4OHokiRtem7ZjjbSBXB9TIw2O?=
 =?us-ascii?Q?Ra4Z4bB1/nK8i5SePB4rTnfSellK3tHH2uYhQ0xZXO2mS3c+4is/nshMACFU?=
 =?us-ascii?Q?t/QKvAGWujmje0hrebyg52LbPAN8GaZj79QwAfjcuaTSKRtHDy0oUS+q0IjS?=
 =?us-ascii?Q?L/GvrIyUkbo/fn2Hu7ab3H94ZZFm1Bx6MvgSVxfvbkkhdfMGmEk2tlSLhb4N?=
 =?us-ascii?Q?QrXqIHdHs9o1f61lEV/HqFipvrjP3iRfK6E7LZIyR77BH8d7ORZ3WxYRVkMR?=
 =?us-ascii?Q?hw79itR4c7bvVsbu94fs93FKXao4hZGAlL7W+t4uoohcwIiS5OkUnrC1MG9g?=
 =?us-ascii?Q?j/b58yRBnlHzhjMA+PfY/Nw1s/iw5BWEp2I1FJdkwNmEXDUkrvX2Kl4twqvz?=
 =?us-ascii?Q?3+ZCarxo9taKQOFAE5OEJw7lN90AdobeUvGDNCBH9tic3ujdw56Hqt+hZXFn?=
 =?us-ascii?Q?matl3rz9kcoYv8ucmled6XopavQ67zL6qU1XLdTagDsSh+3x6QGA4n4uDXEg?=
 =?us-ascii?Q?bnNV++a2p/W31j153JAAODjLZiGtbrvlV6PrR10j/VzmMYN2m2IhywFuy+5Q?=
 =?us-ascii?Q?cEHr22jbZ1xsYvOaaFTpCjc00/auRhpTHlgj7Y1h9DN5tUg0rkQJW9yPr3vE?=
 =?us-ascii?Q?z1N3lIV4wh4FFtuGOkhBNF/m4ODJvaNJEZj3VM/K7kg9UBxCPUaEiD1Rfl0Q?=
 =?us-ascii?Q?dw7mpAjCLcnJIwfxjHYdmdXVTlFVY9Llkznlb7MY9cwE9/vl2BRCMhnhcvM4?=
 =?us-ascii?Q?9CxGoTXJPnwirKC/zYO8IKjDBpWw8e4hIxHZapNWgkjGhQGMHieuDtFHlvJP?=
 =?us-ascii?Q?TXUx8wp0etwbzsNtgtSHLm5x8mEUsr8LxGG+qrdEdh7Qc0UpmR7dNyZkCDZh?=
 =?us-ascii?Q?HkTxf+U5THp7CSkO4d9YtaoBhqxx+JAtL5eYigXBfFVIu3h4vrxr9UqZ6muo?=
 =?us-ascii?Q?9imVn06uet5KWcTFIyltlU1QF3DValq3RbqPPJW3+DUFdfFogPjRsRDAZuTf?=
 =?us-ascii?Q?d7PmoPw0m1jSfXc8OnuKlMd3JUdwKrVLTwMIJrD7Bfb6WVvwpx19xpvzbWR9?=
 =?us-ascii?Q?5pTI4fu/fsgbg+PEJqVCPVMPSRqfTKgsCWmpFIfddqz1hDWm/Zgw2WGLOB7A?=
 =?us-ascii?Q?q9sA9QybtSMzICzSMNo0p8Zp/oZXhqLb2xdI3wT9lFhhx7bUNCmH/zhu3crJ?=
 =?us-ascii?Q?B5cqiLVEDWZsafC9JSKmASODCGfjnloiEUyuhxiYyYVI50RWExFewxV6Cq3+?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea7ea84-ba18-4ff6-238f-08dc267a003b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 18:41:01.3454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mRoMsrve77mbN2qGyl5X66GBHli+gK07vO0VWUu5VxFDeQeAHDJFQHuKTIiRrKevXc5NqE6x2VkV768SXJvsCCrizWxOlCLwTWC5ilDy6+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5313
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> >>
> >> Good catch!
> >>
> >> ...or even better kill this function and just do:
> >>
> >>     *dpa_perf = { 0 };
> > 
> > We need to reinit the qos_class to -1 as well. 
> >
> 
> 
> This should do it right? The rest should be zeroed. 
> 
> 	*dpa_perf = (struct cxl_dpa_perf) {
> 		.qos_class = CXL_QOS_CLASS_INVALID,
> 	};
> 

Yup, was about to send the same.
