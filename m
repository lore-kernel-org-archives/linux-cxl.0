Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F128936BCD3
	for <linux-cxl@vger.kernel.org>; Mon, 23 Feb 2026 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771874875; cv=fail; b=BfI1XmJfyD0NSN6dmWqEMQZt95BUr6P+D2jfjqSPfFVPwxKqM8WDIZToEGfZ9kaKgzNIxcTqd33l4THcfrU5DWufShrE0a8m/8xvOdi257TLtAwV1i2meRymG1SKxxn8snMlzdwyWBSBa9y2h4Mkwp6+VbGV+W3iIE5xD3pXkm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771874875; c=relaxed/simple;
	bh=4e1vRk7Az5y521GdJYIhzNlSegbkFx76f39WNmKnTKM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SHXMI/sfZNtzj3BnPLJj1HakDDmgMvMAMbb2cV21JS2mBQuTksewGuUCF92MW9EhqaKCa4ZD1TB6TvOiURHonvojyJqUZ/RHQFNbQ+ht000VvdupsdMU2zIsDA51wc+6HsAAtTHiGNvUozxRg01et0o/twkGqMyldTadYPkxCEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UxYCRQ4x; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UxYCRQ4x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771874873; x=1803410873;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4e1vRk7Az5y521GdJYIhzNlSegbkFx76f39WNmKnTKM=;
  b=UxYCRQ4xOLbM9dzFjF8qYrOpdUp/tV6uR7sK5jOgSsbqBaUcRHYQtoUB
   DPqFJRrsdgjPee1KbC0eWlSYUs74wcCs/4dQaqcSVRuVar/z3GZ+Y90Ol
   X/n8ZG9ivSs/W76aLhUhX2LzXtbs8cG0T9bGJA0U1bFrzmxZJ9hg1JbbM
   1V+2eBl+66PHW8nk/gHe4ZP6FliLluX3qUvlNEM0QfpijWOGaZmyn0P0h
   XyO9EJCga3BHG8UXjXL8BZdhNMXkCwzr6HUBIGPTLKb6l/9JTZ6mHEdWu
   6lFd1ph7TWXj5qrt9bcMmiHR8AoW79z5s17MH1BM/3sUnVUgnGMijvvTR
   g==;
X-CSE-ConnectionGUID: 5jv0K0RuSL2126c6s5iyzA==
X-CSE-MsgGUID: pjYTrOtrQhmbcslSU7W6cQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="72982795"
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="72982795"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:27:40 -0800
X-CSE-ConnectionGUID: 5QkswTlMRI6DLh8TWx9iyQ==
X-CSE-MsgGUID: yAhUtxXyTGyRGKWVJo14sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,307,1763452800"; 
   d="scan'208";a="220659418"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 11:27:40 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 11:27:39 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Mon, 23 Feb 2026 11:27:39 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.14) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Mon, 23 Feb 2026 11:27:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Un45T76BbOFkVc0yrczPfm/1qknxW5QMa8HR7yMAIQzP/zMoBrSxdTviTAproOLDW/Rew1YBaFHFHRGW526jtnM9bKAhBRRWwd91mZIRVYQRUZNAvFibV9+8842EI0RZDus8auzaH/MQOFs6ub5OJ3uWtyUtRzl5IG3FtW7LPJ1djj6lckVkEnJSpnqqBFj8YUMhj4HZVPQA7avtD10WY6NGKXjbZ96eFBXwGQc/0uO7uU+bYa2QTiP3+ecZUFRKzMsw/2LEbsjtuPxlX21yyLRScahMwRG3BFMiSRg2jpiDjpjYKex1JeG+yw7ykSEWHe+WwQnrFYW3UwLeOzrVGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C9PkLnL/t07JtTqbEDUEWmdAHRUyOwGBWkp1ukMy/DI=;
 b=gzhkuiPRDFOXlCjx3ptTfyeH0J8OPm78b0oNuIrKqupRHdcft0BE/00+4PsDYzncGdka28RTvZ+SIjQ0B0YopBEPlYNbQLOY7/fux/m5v1ALkYKKCodlRwH3T454+R/Rw6upsqBz7ETOzfTgiMcBUh6DzcaxBW0MYxMwayR5yOEPxA8mfoBxB1fu3dPckRAmklLG7RbscyFtDKodZJU6TfOzKSSL1p7uy6LYjiuKU2ereY4b7DKi3UPDeGY+hyfChtqp2o76NPLp60C9jezu1BxunrRyFpmHXd+eaWLeQIyHu/5xczm8Gt4+8LCwd7UwjryBIBawtRzOvJhkJ0gs8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ1PR11MB6105.namprd11.prod.outlook.com (2603:10b6:a03:48c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 19:27:34 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%6]) with mapi id 15.20.9632.017; Mon, 23 Feb 2026
 19:27:34 +0000
Date: Mon, 23 Feb 2026 11:27:27 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <dave.jiang@intel.com>, <jonathan.cameron@huawei.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] cxl/mbox: return appropriate error in
 cxl_payload_from_user_allowed()
Message-ID: <aZyqHzgpfv5yxx54@aschofie-mobl2.lan>
References: <20260220001618.963490-1-dave@stgolabs.net>
 <20260220001618.963490-3-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260220001618.963490-3-dave@stgolabs.net>
X-ClientProxiedBy: SJ0PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::11) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ1PR11MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: 052263d6-302c-4dd5-bd90-08de731198a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iHPRu/YVfEwKvV96kLfgRx4Xn55vS7B4uOotOsF78vKrYCwvEObZmtpkDFue?=
 =?us-ascii?Q?AZwR1hYGMbx649+xL0SkSu4VIFFM0g3HfrZrZZhMA49i9ta2t4aSId5amJJl?=
 =?us-ascii?Q?FeluhwYoKCnwXqqqapCWA+Z3Yt6wU5jciwO8oaXysPTowqNJBN3oBGVHLAhx?=
 =?us-ascii?Q?gLVo74D9ppfSF/0R8ov+hWVfGo3C3mX0d+WpbO8MWJF3ZvRpVcWpu+RqvVaW?=
 =?us-ascii?Q?CLiSs6wgfU9z2aLeAcLgym/TO1zxNQztZNmsbvwdIZIPc2hbD0SpzyRfFMY+?=
 =?us-ascii?Q?kgfGJlfySir3pq3i5YR4164XSLdfH9aT5LG5qEa5HepWMR5oKkRVorGY8cx0?=
 =?us-ascii?Q?b7Nke+W/NP9B9YDupkgy1LuANlcO2noyz4MIdozbVO3bkUOgi5hNZCSVmG+7?=
 =?us-ascii?Q?T9ttT4vjP2ZGZhhNoCTI0QOBeoQcCfPvfq5MqFEg5GololdvmFS3+MGXe57q?=
 =?us-ascii?Q?BwdX3BI/KHcGhWupd9dZTEcMgalPnUdWcz6UeQIB67jYHwkLkBAFXtUsIPQd?=
 =?us-ascii?Q?u9GChBuFZwxFW2CrYLd4D5VjwCp/rdEl8n7t4Jm1ach/qb1lkpxMzaMJ0LTl?=
 =?us-ascii?Q?G1hDwPhdq0PVNUPAfSt8nLNvCkK+GsliPMsDNOgmWGWlYzwS9+wnTVr3y3tr?=
 =?us-ascii?Q?rSKtrakNH/EA+nwRca1YNqBFaXI24v48FeODd8w7qbGOzzmIfNGeHV0dNfEC?=
 =?us-ascii?Q?oz6TQS/S4Vw/C9N5rOYI3gyVhr8GVBN6r/NfTC79uBd5gk/wcqBiTqcTGz53?=
 =?us-ascii?Q?2eva5UQobYxbypP4xGNqqdm17BL50lEsfUlooS54Z/Llk1kwBSU4+FaGoj5/?=
 =?us-ascii?Q?c5L5dgf8uMUmv0Z2V+7FyyN8jiAatap/t3zXGhzIyWFx7ygbxyrXhXGaQDf5?=
 =?us-ascii?Q?ZqihZNxh91dugo9tvz/+qkrbtjPjgAOwMeT3xJebInSITz7p/308HF2ob3q/?=
 =?us-ascii?Q?WD8J1mv9yGytkbtSTA1GPap81dqB1tq0gGyxOl4UePEjlwNXiI1jzBccMEK4?=
 =?us-ascii?Q?HUa2oqbrV8MZL42qqQOR5z/yJvwqJPqkjRHeWdrCyiA+T/Tjha27XHUDFa8a?=
 =?us-ascii?Q?LQq6x98sMMQyYgA2IXSYtqdzHWsfnrwKq5G8/QSvS+SWy8zFwDcd/jpOTOG2?=
 =?us-ascii?Q?linSjgBJLkBf+ikcDj18vqNznDIsUR6JPk5gmBEpWqzUCVX7kEYXi3Hvt/je?=
 =?us-ascii?Q?YuGZgXyv8Yd5BZoTB40xklIXZeFLitc+jsWC39XW9Nyr2CWnP8+epf3Ksyd+?=
 =?us-ascii?Q?PtLdriSuanfzGpud7PhsXMvUACx+j29wp4QTWSzOkWrn6nemICgKFBum33C5?=
 =?us-ascii?Q?eaemuWPWwJz3yzgiDsouxRqxIyolZ/2gG3vFjEK+7sNwcrUPsmTP4ESynMOr?=
 =?us-ascii?Q?2tnIiAptwCKhIjwsZxSPwAK4a4LlgQQYqbVPxT8juAkweV0alkC4u4EjMllj?=
 =?us-ascii?Q?p6swBN1TvsVPQ0wyCABD4lSsGh/r71L9kI98ul4C6Mu3wwYoADAHOQTMQMRe?=
 =?us-ascii?Q?tXZm2wsrtwW2l9mzExGPFmQLrZnbJ+DEGeNSbPFxtf2UTLkDUEglvC8vjOnI?=
 =?us-ascii?Q?lt1yIBy3WUIMB4eWQCE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T1XE3v4zhATCLg+4vFG1M1GdVyKNuGBIWyCw43YkKuz2egjtgcE6xqRa6Ip6?=
 =?us-ascii?Q?iOlYZAi/WzObqPtb84nSNpxfiUGLUuDZQVCXN7SVBj5/G8f00JcamwXpd2WM?=
 =?us-ascii?Q?n7Idy6vwo20UDk8GCSMxS5f0jWn0eaWQD5j09AxFS9ljyfzORh1/0rTFY4Qp?=
 =?us-ascii?Q?n96MHjdn3pcXmfUZfWpw3OEJHhrvZ9tNAYDB5vtOcBkAA+aYLM7nGNwVkDM4?=
 =?us-ascii?Q?q/JGfCLIXntLBJr05SIlpOluRXz9EcmTveQYVARPU/S7s3drvxGLp/nnJphN?=
 =?us-ascii?Q?yv+U0fUxgdpx+rsIjfBrmRTqS/csHmCJPw8wqefNjRU9gxLdwtlp+55mnfi9?=
 =?us-ascii?Q?Ll+1p+PutIXGiXQGYgy5FhxO19NvMVWQzLt5tqLiriLNMmEAgc3XO1RGv5Q4?=
 =?us-ascii?Q?g4JATXyodUbqkJ6qodkCgOggz/FvcIZshAySWssXQrTkcjORnAMpRMTUcv1N?=
 =?us-ascii?Q?LueqE5wPAfO8q+IVlNu4k0mKgB8a2yO2TdR2SFmCFMiPfqpPjY+mYABF//hQ?=
 =?us-ascii?Q?6LyRkTrlQ3QZ1b0A4S/Gvr4pt6coUAiEsnGBL4sVcFmn26Q/WR+kGulr7nbN?=
 =?us-ascii?Q?0zOW3biXA6RhBEt5ogkHS468vqSP4UMlnLqexnjVQ1QKc3GKI+8N1O2RaRSQ?=
 =?us-ascii?Q?BTRmMiep3jdJC0BF9FB0cdanIEvc77WmsSfOWjbR1qsn7TUjoMkwLWX/BdR4?=
 =?us-ascii?Q?IrFCwWdQumljJvKr9lGzLwuNjZEeWMAXC//+iiqiXl+pN9tfpdKOBnPklIu6?=
 =?us-ascii?Q?AcrmB/PHTCGpYZV8qNaTjjTCHZGna6EgZfp4zBcGMIBDE6yXEBbd/wQ9/qFA?=
 =?us-ascii?Q?Zkp190c+e+4U6MhwU1dIqns5YE6x830aE/iG+zx5CdktOKmxVhrPUwSwNTQp?=
 =?us-ascii?Q?PiWOiwUjrDhf7ajEYLgJu35fttIFqRNFwfk+isKYnURtBCHAQ9vXlx3Gmo/k?=
 =?us-ascii?Q?nryvrYqfdUcIzOdUZVvheILiHfAZPcWz9WZVlj2uGkRNKM0Y+epYu7uSLntQ?=
 =?us-ascii?Q?Hcj973Ac+bEDSrjE/ERlHUxGDR84y/ERfV9FW4tHiPvEQCjQI28RzszcasHY?=
 =?us-ascii?Q?g92ioC8jLbWg2EPRexnw3jxxnFxjZSCfTOusaaqdyB3o+rrPJ2D7DN2xxCLc?=
 =?us-ascii?Q?nXNpzpE0TE0o2wXOGZ9sE4Q1U7QDGxioLmw5i5Tx9kYvSrbensC2EH6wS49E?=
 =?us-ascii?Q?Vqa0RCX18JdOBZnKcNhStJOFLrIVUC4Ku9U+f9xgChDmvfY33UwEdoPmTxaB?=
 =?us-ascii?Q?UFqRi632MxeQVGdoQUy7mn394J+LvO7gvV/ovV3tQG8JFR2ZH1WrieMEP9xL?=
 =?us-ascii?Q?g4cqKrc0V4XB9HDTbw7SdAm5JdhqyRciaM9MZH+buIN5QwynQq+IokklyGgf?=
 =?us-ascii?Q?9pSTc/iYHlaPw68Ek9DbX1ZCIpVQzMWBLLk+p4QPIYKyC4xc1qzmItYlw0Qb?=
 =?us-ascii?Q?ZAh4+TxfaYWTl5a5bdAdOcANCvcfWOhrjUneCORszV7OLkXMYY7VKe/JdIGn?=
 =?us-ascii?Q?xxHNVSFmTurfgDXmio5fT96zLoTfxXXsmlMObozmeQKsADbov6zSQnnRpEE/?=
 =?us-ascii?Q?wNuWc9SFR/3DbygZSuC4mThDLfDQ3nuvZypxOv71uVQ34qblzxu5dKUNeZzt?=
 =?us-ascii?Q?H7AMvHYHaj5Iz4n2pAOo8ezFO7CsdFB39EdXSwniXBY81AcMefV0i+UJn9HI?=
 =?us-ascii?Q?bX3GoBWiRtuEX9HoCVb9mPMy0zY/MqNkrvPLLhgZK3bEE9UDJZOo4MztHie5?=
 =?us-ascii?Q?aTDV6oB0/kzBWUBWtZYUDF8MZ+CCHK8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 052263d6-302c-4dd5-bd90-08de731198a9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2026 19:27:34.7564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a9siWrvo7aGEegmWW1TlgK70hLBvTmasbaNbw9fE04QVwMCBIudz2wQpxZBRs++EJhrZkO4fhdJI2Ab75MwFeUDZQQQCHxoeGEqxrowxwe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6105
X-OriginatorOrg: intel.com

On Thu, Feb 19, 2026 at 04:16:18PM -0800, Davidlohr Bueso wrote:
> Make cxl_payload_from_user_allowed() return int such that the it can
> distinguish between different errors. The payload size failure is not
> well represented by EBUSY (exclusive access by the kernel).
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

After airing the ABI and raw-ness with Davidlohr, and since this is
expert user option, why not give them any info we have without worry
about expectations.  So for me:

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip
