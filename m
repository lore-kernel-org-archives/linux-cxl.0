Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463EE3C492
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jan 2024 06:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706596535; cv=fail; b=s2HLQuzbGe43Z7fiTIdw1mUpTFjkdLT0QL0xZziMtGkPP8WVBKaqeSLfRbzrn/yrJwjZjn+eO4nAbuGQeP+HJzvpX8JPiuvpNDJNkyf0Ywdbxd+PWoD7aYa6slmQt1KYKT2O+5D5s/EhiRthL9GrGHraJaIYmC9W8mbf95i/CxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706596535; c=relaxed/simple;
	bh=833SPJnC0W7yr1QuLKV0MOhoCvRCLh5NhkKv3pbMMOo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pjjfmPYDY/uljSZX1GFm5yU8Iul2CmloApoKlEi3yzhw02DhT5t5IS+gIzQDFRYZMGAEsTIl05RPCL5+bFMpQt7EO5awq04+0vdnBT6O0LyS6kUm6QMkT6ys3SZtDrFGft+eZd2Pkda6uQD32uyP664qO4BR5VJsBvsz98sM6WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WtdDfxEQ; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WtdDfxEQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706596535; x=1738132535;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=833SPJnC0W7yr1QuLKV0MOhoCvRCLh5NhkKv3pbMMOo=;
  b=WtdDfxEQnH5AJYgV/d0j4CMVk6jzfp0y8cFIYjcmptrg0NgQNvHTBt12
   rfDTQCNxy2JdV/JoA0fxsuPepv90TSjfp4+SlcWZ+RcI2jhPqKSxzu6Eg
   NdGnRJNpRJcQuXvxod2xYZcdbjuAjpm6qeFiM3wEuBeyJab5onf6N+rKJ
   3fi0dCnWxEBmiGJVswrPpvjd4E0e7+pwu00NCjv1bAT33hIsdH0iO0SB8
   kBflBxkJQ1Pc2sspDNGGEVuB9wJAVkY8mtcXfqYpWwOW3tONoQFNTU5Y6
   UCO/Kig2t4Rkz1P40gocpvm00Ur/PrZ5dnfpYTKvuf0HB30JgRlD/OD4N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="9922613"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="9922613"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 22:35:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="737672958"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="737672958"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 22:35:27 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 22:35:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 22:35:26 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 22:35:26 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 22:35:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxzvkdJrrfjfGBZpuKFVMHjehjbGHUw3J6JNwzicTHSN8CGmli6vt1EcssntMLxy2qe4svYnaSV6Q2GKoImOyswdDngnFBGK1j669V8//aSRvWxWYkQZZHjsJ3w9tDc2ySMm66sgCVuAYhTY9XKa+o2NmIixDduSzdjB+0CStEmls8EuCbly3/ANa3jMTxoryznQxGxBaocxZHbaqOHpQTtsQ90b2/MVoKVfxl4IdGDGVhCDPUhFWw+8YFFHbIAYTTrf9+FG4tf3zF7Ei7Ncu/9S3KVcXyCvfmVKq5Wg7Ll1DdlRd3cUadlwoSL79Nsooi8+54DiOZdzOp/IlkKAWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyzDL9ssZA56LgFD5Rmc4dQLkIfgOlNF5hCKCp5LBpA=;
 b=Xws31pmpPDABQGZWhkHAjru1rz2ILFsOWKO1pWtcxW1EkLrCADZ+OJ8BTz91jW9PqJtc4rY2oEUw74n9/9C5bNdvZFF+pmcrgIpBt/SFDlUhWYCw6/HFdYbjCPNvOPfk8BYJDx5K4jTprzj9kVMtsoWkhrChjcVUGEmTjV3FGPJBhYlSPWLDsgX/NzkuZxtOm6N3S5T/Xif0amteqZBC4iMoUn90HTYBMs/eMuLbW8328+mMxRAVuAwtDjroSXPW2TiNkrpJQiOQX6o+GX7mfeZCDkVvBFNoUNFMEkti5btYG/ufUjtpgTKue53vfUchbNnfeZYD6DmChi6PlG73yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BN9PR11MB5530.namprd11.prod.outlook.com (2603:10b6:408:103::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 06:35:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 06:35:18 +0000
Date: Mon, 29 Jan 2024 22:35:16 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Quanquan Cao <caoqq@fujitsu.com>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>
CC: <linux-cxl@vger.kernel.org>, Quanquan Cao <caoqq@fujitsu.com>
Subject: Re: [PATCH] cxl/hdm: Enhance handling of invalid decoders
Message-ID: <65b898a491e76_5902829419@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240130060517.19942-1-caoqq@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240130060517.19942-1-caoqq@fujitsu.com>
X-ClientProxiedBy: MW4PR03CA0197.namprd03.prod.outlook.com
 (2603:10b6:303:b8::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BN9PR11MB5530:EE_
X-MS-Office365-Filtering-Correlation-Id: 319adec2-51c6-40fb-bba6-08dc215da055
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RkzA1ejDvrDFey1MyIEPdN7SnYgO6DuuzvqQyBEfIx/PWCl9yOju5NJQisVm1x1KVDw0HciQTxP6k1FvcTFes38totNAymygw+PtbYjAvDT5idAbDIEom2DK2L3mEu9rm56Fipi8hYvIE3U9eFWqKx2OszrwBem/6xWizDZ1ezq+mRzpUOV8pvymdp+kJP1UzByYF/CeC/RhF/H+YYJ7xA/bzLxtpf3kPDJGiq5bzsNvt5Fpa8+PMmACDg0nKI4aiHHnL+03JxBP14uswVfqfbwHGMFeuPc0XyxXwhwCk5ffyiBfZLyspFwr4EQB6btOuNrGy1G2nx36rj5mLWmbvTzBDg4wvM5l1nZU0vKQqUpLeqrrWU6lclvKCDWQfaxrOos0V8lAVGz7Y9JMs96BKc5+w3yOD7CPRPGQVBSqfA7kjRnCzg5c5V9B84WObuRwhcxWcWNkCYBqV+x/Ca5rrRFFXe6hqUZaDM6qSPmDhiixssmtpT3vNbUc7ejt1VERxH5HPunmefOMYr9nWpo2A2L2yZbtDmA9ac6ddtZgx0GtmZ/AAOk3wLl0vzl1nlan
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(4326008)(8936002)(2906002)(5660300002)(86362001)(66946007)(8676002)(66556008)(66476007)(316002)(6636002)(6486002)(38100700002)(82960400001)(6506007)(9686003)(6512007)(478600001)(83380400001)(26005)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+kSpOKCE5TP9c5Tozp0O2VGqbkebyLZPkUK1Rx1VKE+SwcgQDkVK2VBim6XK?=
 =?us-ascii?Q?8E6rRf8MGcY4Ej/IJEyIdOzZ1D5Q1cStXUfVRGi5/KmEdNymi1nXwS4sGdZF?=
 =?us-ascii?Q?a7wKENV361RdM4EsKKNmgq0qbJR3oEBqBDtGokLCpx9jbvbuJYTeiKn5lj1K?=
 =?us-ascii?Q?JGF3A5lHS7GHUp+GFnXCnlfK4j40dMLVvZMp9LRqapEvvHmDF7J0OFGKSrbW?=
 =?us-ascii?Q?rrQ2MsV7OkHIfLBnG8LZFoFFSxg9GC7yZqdo4mKyGsr2Alo3ReLC1eGNBOb7?=
 =?us-ascii?Q?5W/phS6oqngK3Y0c678bvktGGObAKwd4v7yxrPd2ZUK9GqLClZyV26ghLLcC?=
 =?us-ascii?Q?ysbL3bUGfmFf/E4cY3djKHOuUJoiisuynxfYRuupx5ncskdl1tmOUiKa618L?=
 =?us-ascii?Q?VoP4MtCdRWBrNH4yWHajaV4tjZhIpmCaixKuRg4CMoie62hW8YygtiGPzkGz?=
 =?us-ascii?Q?zpG4t3C6PDNI/jJw/WbymCeYYL3ARSqWQrNmobiMUY+H16Gh6CxtbDYzPfDX?=
 =?us-ascii?Q?66kqg8ogq/bn2Ks+KpPaVMISo6D7W+HcsgZ24BGYGCRe0xwV5N9pZ8PbAr7o?=
 =?us-ascii?Q?wpp591EVJm9fO3R325MphG2+oS1vB1ze+GeTA696iLNscKpgTU36Av/JiAAG?=
 =?us-ascii?Q?3S0D7K6xrz8Hh2nnzJ9RDeKMTJ4MgHUuR9I81hzDUHwYRgNn7Jsdiitrvk5b?=
 =?us-ascii?Q?+gr6SuqPGAMNQnE1L2BFnYjm6cnQ2g7Ldsd87iH9Ff4XZ1DerUFWG3JGbQW5?=
 =?us-ascii?Q?fjBwtIjJd3+LjrZ/IOkJ/dxzCmUY0n49QqIhElM69R6bUMXd19lKPIx2z3YS?=
 =?us-ascii?Q?5zkBMWGcdTPLzrkBsSo3VCP9JWjEIjhtnjjJRUW4a+D/NlVebWNKsCUPTEBi?=
 =?us-ascii?Q?VGNodpksNs8LZNcvDPTTGrj3KYH3Vyspp4l4lCuRl967SanVfw5+itZT9kkR?=
 =?us-ascii?Q?Ar8JnSwiSoHnI5TzFrvwGGhV+OYEVc1bEU8Gx+U6DLr7oGnwbd9qxN8+Lupm?=
 =?us-ascii?Q?lPsWXM6XLVrzbWFy5dirp8Xu+JV5crDNBG3g77Zu3EfX6T5r62t2SMtGIqgG?=
 =?us-ascii?Q?VcAMsocUp6wGjvAywog7pXAkNz6Sj7GLaK881rf3Mf2kTmANqfjcWPSgpSQi?=
 =?us-ascii?Q?9os4Aei/mzCWd/Rnt7UCNiRRD5k3bhY05a6KybVlo0k/dBFPTgLsze4nSaPK?=
 =?us-ascii?Q?jmZL77FzOz3QdDjDAPBXIuBAcxy4ywl9Lerqw2zvakkIXmXhBjoJ7INd38bW?=
 =?us-ascii?Q?qLSegCqXQIo7bm8wssWBzOmwCaWqYqD78UJIyCF/vIlclp6MzzpxToZVctry?=
 =?us-ascii?Q?UHJjVhWchxevapibTW17KfPN845ZUhhFzU+Dye4hBcyh3b7NkNcjgkrU9EPJ?=
 =?us-ascii?Q?k9TSAuEdh0szd0Ui/BtP8MbVbWl8htmngMRYCHhQ1vF6Tn+41Kw2T+yFiac4?=
 =?us-ascii?Q?ANFhqTTf3EJFZSQF/FJwzUNdDojvWp0fCF+v0nkFuluXqfL5moACaq7GPlkn?=
 =?us-ascii?Q?5qwq4oVYWlS5Xa/Grhn5NV4knmtrghnSrFkZ+O9Se59Jin2Nn1VeACgEzEU3?=
 =?us-ascii?Q?NGIjPmOdSoU732/nY9/X+vlz0n/66Z9qJMYRrBFEB2XJY1xvt7mcAcYBzX7L?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 319adec2-51c6-40fb-bba6-08dc215da055
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 06:35:18.6563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jf/R8r/AF4NCgmssddxXbfhXIwwahENBgQdE3C1R2+MkNkHAi4UyadQ/xw/ccnskxhnLSjsnuJYz6rvByvK8tWhZqUISV1y3rX3Gqeq4Ovo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5530
X-OriginatorOrg: intel.com

Quanquan Cao wrote:
> Add the condition check "base + size < base", enhanced
> handling of invalid decoders. This check ensures the
> decoder's address range calculation won't overflow.
> 
> Signed-off-by: Quanquan Cao <caoqq@fujitsu.com>
> ---
>  drivers/cxl/core/hdm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7d97790b893d..b8978d1c7a24 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -816,7 +816,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  
>  	if (!committed)
>  		size = 0;
> -	if (base == U64_MAX || size == U64_MAX) {
> +	if (base == U64_MAX || size == U64_MAX || base + size < base) {

The U64_MAX checks were added for a device that returned all
0xffffffffffffffff on read. That happens to match the common expectation
that a device or a bus in an error state starts returning that value to
MMIO cycles. So this was less about validating that those values were
sane and more about having a convenient point to detect that the device
is returning the common indicator for MMIO failure.

Otherwise a device that reports an overflow condition is definitely
broken, but it will be caught by other address validation code. So, I
do not think this is suitable otherwise it would open the door for many
other device validation checks.

I would change my mind if there was an example of this breakage in the
wild causing real end user pain that is too late for the device hardware
vendor to fix.
