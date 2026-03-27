Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC4B19B5A3;
	Fri, 27 Mar 2026 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774630933; cv=fail; b=lRoS6HDMs1JENVdS0mbyWinrWTc5LAZ2+vx4xCpRKydL1DLBYYNJmsN6QXcyf3Bypk4eZZvgy1yMZbUfVzdgiXGP/21eqtnrvebFM1UB1mnkaJLxohhbxaQeGyGJOsO8fKjc2p1yX1lWw4kYIEZsNmA8BBn5bhhJh/csdcBgXSU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774630933; c=relaxed/simple;
	bh=rEABx8RzR3Tb7JJSs4Yfqk3pf1BDhtYVAB7H9FjFb0o=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=moNNHrQdri/ZqKaAPfizjPYhzcIFpvUFBj76KAfMZ8l+u7HIktkJBrM5kMVka9NkC6ROI/4m4usXyMi5ECs9NOlSEvZJbFgnc+AeTqyhhoICPTO/BudoyatCFyh1SsAWgA4WJ5Pr9wpMQ83Tp9s1pVIf6sFVMsFCuDeNxucz014=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=koKPlXIo; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="koKPlXIo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774630932; x=1806166932;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rEABx8RzR3Tb7JJSs4Yfqk3pf1BDhtYVAB7H9FjFb0o=;
  b=koKPlXIoxWG8mNLWwqTpBwJmrEvN0WKqDgixGlYITtsTkHqi/7rOGK3u
   Nu2djRRfOuvuYZV6d0G0iseQdO1pq7eF1dxtHrNYwk9sCp00NsEiV/itS
   YpdEbZFqgvLVjBr0BL67M9m4AdgjHn5FTwFlMHHadi8gktJDYD+3/Ete2
   hWpRrYyqVcQTbSgiCn3SuYV7miUIjpPKIwmsz6IQVeYq0XAaU02SGu0Cv
   JD9UeqkTBlZFAVpa4mlNhHCnwI0dRAf6Fhk4DB1uTWgXyK0JdOC1U9jBv
   a5uSIpJgwwTHxd9DhHbNou5hw4C4Ts8P3NtWNmwapIMITvMt1CFtzQz8a
   A==;
X-CSE-ConnectionGUID: kYz8I5b5R5GDqLtZPAsZIg==
X-CSE-MsgGUID: CByIKZE6T/qRnXywMI8fpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="74739170"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="74739170"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 10:02:11 -0700
X-CSE-ConnectionGUID: lUY4PRxKRAOdA37tvIhPMw==
X-CSE-MsgGUID: Xzs+lFCGSp2jcxrslOmAvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; 
   d="scan'208";a="224412846"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 10:02:10 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 10:02:10 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 10:02:10 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.62) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 10:02:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ToV6fq/vAgecxkk+IQ+ZZ17HhRqJi6e5sRA7O5K51esMGBgAVYQtbeWjxUs59TiKHoSvZp7b1MRJ537BAa5TjOG4Z2achqP5+MlqBv5yQrwHvB7V+e6xsk2Jpa4WCPrnlBF7Dmd76sj0K/mvPW6Hh3mkyASy/3BF9dm81nl0MtbaosDeP1stda0VOpAg8VFySS7Q4y4b1UPHxCwFhWhIvw3i4Llc4S1aPm0GADuBJ6eXLWRy61c94akanC3RzgQM9RLpLbKT0KOQT+J6J3upg3QLNEh6umf81u9jbHTjJdwHK3YIFhkUankw8iG8vn/T/dKTQGHrPXC9j78MDiB/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVcnIsEBmrHqzCIvGTwu6x+rAucnWVXjGNgSJscoxes=;
 b=Gehabi0eUun8/nUfiGkLdJ7OQer0ULifu7iaS9H06VD3f04BrBT0vPeeOZLIxzbGv7EosY5zAHCN0bdwhT7UH3K4bybn+2u4TH9Nj12KzAcre2Dl53VHT7i1HhD2e3fZN0fF6xnLIDyXdNLjncgW8QloSbjUCMjza00PnW8+vDBddXfh67VeewbiHPWN0z+HYd/Jlw9N3iYYp6IUby5bgkB/sz6LKqAygCTQWR7AaxBENq5ecZeruUxMcaLvm1sq1hFeXmo5nYzv9i6y6r1mnpAuIQqlJSQ8No8sqANIZF05hm0mWpQUo8B+Y/N8DxCbWVkRLY48Cx3T4MxKwO6d3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by MW4PR11MB5798.namprd11.prod.outlook.com
 (2603:10b6:303:185::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 17:02:05 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::7d4b:a049:aed5:d2b0]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::7d4b:a049:aed5:d2b0%8]) with mapi id 15.20.9723.018; Fri, 27 Mar 2026
 17:02:05 +0000
Date: Fri, 27 Mar 2026 12:05:56 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Gregory Price <gourry@gourry.net>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>,
	<dave@stgolabs.net>, <jonathan.cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>
Subject: Re: [PATCH v5 3/3] cxl/core: use cleanup.h for
 devm_cxl_add_dax_region
Message-ID: <69c6b8f459a7f_1771f410046@iweiny-mobl.notmuch>
References: <20260327020203.876122-1-gourry@gourry.net>
 <20260327020203.876122-4-gourry@gourry.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260327020203.876122-4-gourry@gourry.net>
X-ClientProxiedBy: MW4PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:303:8c::29) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|MW4PR11MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e68906f-b101-4742-cb48-08de8c229299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: YuUfl5IwJoLF7/7BDt2LpHhA4d1yLn7V1daOreuwr8Sd/a6eMnh9M2mw9YFTCDQgmIDClsDnAYnmbCbpdcmRJlMImGnG8fOWXlVleEK9mMNF3aixP3emhGeV6txWeEuKIDLeyc/Xt4zVdM/prNeNvttVayhJC8uSTISf0qipR6XIdDjzySiwFrl+DO3kFt4wz5Vgf+hH7Q7AzuD1XEeXgEvfAWwZWX1+sqjNDW9SxxrRf1sG3350SAoZwazxc0ibbECi4XCzkE42cWoGGpXDFdedq9M+uRKABiv2lb3ceIQCi4A4R8uYemakAwKFkn8fXyKY9pPC1wn/3CEO99r08jCt2hS35g7U3xRYKnsuxZb7D9mhxmv3fW+XyJWVZNgUhrRktTTp6zxR+qYvtVfNhWLEY3hBNp+pqjtI3zvCDEfscyQUyrZWp2a6Ai+cymAcfHFVyuszFuaOP6xuXmVylm9G9y2OYAd8vzkwxwYZkw8QpKlXCJPxGNFAbMsOyHOq1QgOCfU/swrZygZtd6WwqlPpzypSp+7uRVqhBolVW3jH1fIAARmk4lIHABMIO7T/QR1CCGJCQsxRk3LxHY38ZffwmZUa7xnTYCSchMz+sE3dRE/g3CzJ9FbHmMYTH0+rTsHvUAThbmH412IZXXb6YFvXm38fe1UbDsHNxit+CPh0P/kYc6oWbJ9JlVh6amuzrjIROYIlTsShJiJoLEzWLXrhML2GedK69W95SXUoLy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kU5K0wUdC+UICu/VyC+voENMFR1I4FP9BKcLxAbKKdAKxCBqlFelZEDHbnIw?=
 =?us-ascii?Q?GuFCcgOqW4Qbe7wRqKQ0y4hhRWJUClqF8/cC60/yFMYiVGPAaWpZLpWw6Lvu?=
 =?us-ascii?Q?G6LowasqAd6idFZfkznRQyptM0OirCvxa/q/m5atuTtutx2ojHl5PddpidOs?=
 =?us-ascii?Q?49mEuDjv7WQZRB8Kfv90ZvhsTxJvC4artCr/j4kEQXhUtdsV7Fgmh/M6/7RC?=
 =?us-ascii?Q?Jg1OMhQskNGnJ7PsKrripm3Biv2rXhpTbgHo1RG+RGcL3kvUv6dAeESTqCWT?=
 =?us-ascii?Q?4QpODCpj9M5iWa/p5XxpaKDqF+SCs030QIw0onap9s+SAM0MgdF/vPI3AniR?=
 =?us-ascii?Q?cnrGyKHjs5VlBRWw1g1JRtKPKIBS7s7McouYVCT5SNZcfAqbNFhofBZ0FtY9?=
 =?us-ascii?Q?Wcc7Jg++o+WocaXvwcSscxruprwI3nFHEgWk83ZDkdWe7XOy79WpFSelAgyf?=
 =?us-ascii?Q?7Dtz10axSMkZqRodV0e1t78vzdivCvr3Z3hGsN46z15yVao262UWNhO2mVa3?=
 =?us-ascii?Q?UYmGXWam/3eiu//x0ullLrP6O2tcsnm4+AgeaL4GuammNR8KnF66qLA5ijbr?=
 =?us-ascii?Q?StlwtIivhR33wbHdChGFbvHWLD2bj/b51ZFbJhQpkj35mZE6SPkZB8INDXel?=
 =?us-ascii?Q?Us4Zs42AeYbngVLZNaKdTlbqCvjyAN7YYhagAWjZmuvORanYNfmrAzpl/yvT?=
 =?us-ascii?Q?VC+t2JGox3H+q5g7Mt+89LbxsPyxrrTi/FfRpIGoM76MYaOqs3tSnwLz5ApJ?=
 =?us-ascii?Q?vi8YG1nI9yanr1GVaiRlrcheKzH6w8jaP0rAq+05Y6g8QCFCBNvigzldZmkR?=
 =?us-ascii?Q?RycbUqLQJl8jL//EMX6e4er/Oer3bvbUEjah2GkSuereaqq8iP0QtMt2zFJH?=
 =?us-ascii?Q?TJAbz/WE77FZOvd1F9Jk6VOrKiBIEzSmBrJbECMzWxrDXUiB00RGuxPLMikt?=
 =?us-ascii?Q?R1uY5l67nYCQKA5i1tb9BN87VcGlQWFznPfO5jrgQ5CpWpvwLKzd4+UNhSPt?=
 =?us-ascii?Q?I0QobXmA8uEuikF+2alGs6nP5usKpS/0/SD1chgt+WVoPg3MvuFp7NzjEc/F?=
 =?us-ascii?Q?mvyelJbxpREMgz5/IPMAodTqjSb5IuX5kjTcpeC9LRUy8FvBR4UojtcSTAsU?=
 =?us-ascii?Q?yX2kguONAaaex91V/VcrG6i6+5onAuRUVaX67CjM7okk2+R06APCnyZQluLg?=
 =?us-ascii?Q?tMPncS/0W7D3yFii7rkq1jrOnPRikMVD6r4fsMm+qqCv9JilebgjLxu8DTXr?=
 =?us-ascii?Q?6gAFo1BfCHswTmAyEGz5KeR5El1e21lA5fjUnDgHxyjh384/wJgxXyneZLZ6?=
 =?us-ascii?Q?3xttIuG1bStFQX4uvLJ68A/r6b3dCfNX6IpsborbLi/4xSJD3mPa/4zc/LlT?=
 =?us-ascii?Q?cBRg5tv3hT+/awsxwThGON/kxHaJ2ZxcMXLEuiKyenb6nTPHasfkhbdLCBf/?=
 =?us-ascii?Q?V6q7wUXbR6oGkkWWSozKGYoI6jd7KIRxr68K9tkXYyeENi8GD3Yh3x/NBed2?=
 =?us-ascii?Q?idyUnoi9P2FdbgxG/73hJzX5y7ee328VURrHOR6DfzV88fZ1ZW6PV7hPjHzg?=
 =?us-ascii?Q?kT+5zz0QJN5M1L5Oa3BrfxhpNcePqCIXyPqppXq8yn/Vx1oUURdpGC/0GKPr?=
 =?us-ascii?Q?kFJlP2JSDIhNZPo5laKeJMJWLUTmdQKbciEZJdDg2ryuSUcgjtrr9JD6sLzv?=
 =?us-ascii?Q?VNpzAnpyiCcxM9efm/wz3U+bPwRK7v5s2rfRF12Ckn+H66wBfEfg6O0OTs1q?=
 =?us-ascii?Q?F6tuKiy+hg=3D=3D?=
X-Exchange-RoutingPolicyChecked: awwp2iJZaNuoRBgTg+f3+E7eu1pwbfmTjJiZ0R4mkv2UqZIxF4Fx/n+w9BQNx+fCRovJJ7nAgNtLbSglJPDQSCDtCgZVv0mA66iHWaZv1Sh4UMbeT0V/7rozTemztHxvtBlw0XFa3BYxY9zRRGjy2YdqKfs/qmvmLv4T3L+CST/4k3L5I4PPjoBgkRMjjGCq5WmwdJgZVTqN8xJWQxE5pKx9tpSsELUxIIE/B6MtDsSGDHE7F0YihJyKOwbT2reQaZBfjJ9yiE4c6li0qXO65by4OY9fN44BIXLydX+5RaCw4x3v+lqQH2rpkpmYf6qZzbDWOD90QUnnQDivuWQd/A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e68906f-b101-4742-cb48-08de8c229299
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 17:02:05.0792
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0GPjtN/9dGwhO1GRBmMcI68xKnuEjZw0eqi9i+S4uPO8xfEzQStqA1t+at4LszIxtmOWg7WIUs4kiWGC1wdfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5798
X-OriginatorOrg: intel.com

Gregory Price wrote:
> Cleanup the gotos in the function.  No functional change.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
