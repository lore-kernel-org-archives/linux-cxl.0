Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B24723EA90;
	Mon,  9 Mar 2026 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773084448; cv=fail; b=D8XwRWM6szBwcGnqdaO8wtdj18oDOW68xmjklInTd1FfUUFtMFL+/SZ2LI3laJBf/PEGa953C1OSehBi+PCJrBbc0Es6VIcrSBiavzXC/D4yPFT2gXNzGFQPboKAyHUTahyzIDJLmcAtNdqvJVKiSWaiv8G1ODoTjg7YYdgzjpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773084448; c=relaxed/simple;
	bh=C2cCJ7e92GTS32DbfYZADVzeZfBIfsWADH65Dhk0Gn8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RBqavUQIYIQZnxPCa+XWinHyqr13jpy/3RwXrgFJhGbxDDlNRLWAkjhD+eqwvMonlPR8pDUfKSRTnaycfaIkylMkEwlwQXQVuorhmtFv+0YyFuO/SqLJ438sImENrbPXG76InQVcdjkk7Bw471O4nXNQTYyvx9kSgpGM1+Vzr90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eWTeXfLF; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eWTeXfLF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773084447; x=1804620447;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=C2cCJ7e92GTS32DbfYZADVzeZfBIfsWADH65Dhk0Gn8=;
  b=eWTeXfLFdRtlwAEmwo4fIC3Hdzd07TumQH6QcNpRb7YU7PZcvmEFHw9D
   976zrrEppJreXXNwlp+IQlIm2Lb5G1VyNE/mVflF51/+Use3V/9v7E1GB
   y+sjVMdF9f6T1zuLcErzA8OQYDVwSICKZeC2BTJHxzEWOKj08WJrN7Sd9
   ZObu0nj9ccG6JM/oMbhQJA+dWAFD9UY1S3EQU7UxMb9EWzA/3mBXvWoPT
   d5apVxkxlK3j8FVzA/ufDgCm5IIDiP4reiKVOCXT2zqLYkmu6pz23MWNB
   p5BlQzv05HRLOr5SPytAKURTrPACJhnFzUjUzHdUQ5QKdf9fwiSKW2UtK
   w==;
X-CSE-ConnectionGUID: rxzMEWBKTRSYumNF516K4g==
X-CSE-MsgGUID: OOutjNY7Qk+cTJ0YYJ1unA==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="91692179"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="91692179"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 12:27:27 -0700
X-CSE-ConnectionGUID: zuhGFaYDSjmTYyRElq1+IA==
X-CSE-MsgGUID: bI4tfzHIQOORy6PMbkhhbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="242869298"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2026 12:27:26 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 12:27:25 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 9 Mar 2026 12:27:25 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.50) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 9 Mar 2026 12:27:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVOe89Vi2x5YubYGirVMgbc9vn+ElcJ03LJp0Vl/8Ljz4+E3Ii26+L1ds0sIHt1suKjEgjr7zIar9dJ8Q8Zu9dxwHfeEf/AExMUuONA8nhsu9JcrTfWdioGAL6HNDZxtwAB/eDcGSxYevJg2BhKEYIOIEO7ltT61C5LwAFhSkz2U79W2qYMEm04WQykVJUxeKfITyhr7J+u4eN0dKcuOEQ0kj5S8ez69HuBqnNwVC/xh6pxd8HQOECIvAevLTD+6uheBNQflFXPXiK4PVjZncF+NbzUfKyYPeAWjvWrZuCJzhYd8K2qWWM0ikb5TEp0mmUhTOCWsWw+PeTxbbppvSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3DK6CL7kbonl4LGzg9sAC9e1OW5cpPcCaq3d4tqO6xY=;
 b=lVv+Dw2E99qic77hjb034vY9QfbpUzFLryiOkGKnQZBMlHOkfxVNToqschxHRkvWlCsR7FibEGPcZBYiCkShmyXN8nc1ai336w3UQI7N950on2QsI37rq9rUMy+1eyaKpfUTVP5H212Mibeh2F5PFF6EvQwCq3+8NfnRU3eLhHCA+09gT1Hbh0yGv+/nbJeg8uiNAzlvgGFAn8ak2k9qyH+5V7DzcwGEoZ5TQI67BSZpshPQmORPJiRoZ6G0XDA+1+cVhBx9o5JF7d4OSgTU4szjCNarc5hjUO9FTdIl8mSaPlxnI8jeIQ4CHdIsYzO5Z/7T6GQKmwm/2fDJpLsCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by MW5PR11MB5787.namprd11.prod.outlook.com
 (2603:10b6:303:192::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 19:27:23 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::cedb:24cb:2175:4dcb]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::cedb:24cb:2175:4dcb%6]) with mapi id 15.20.9700.009; Mon, 9 Mar 2026
 19:27:22 +0000
Date: Mon, 9 Mar 2026 14:31:05 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Sungwoo Kim <iam@sung-woo.kim>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Dan Williams" <dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>
CC: Dave Tian <daveti@purdue.edu>, Sungwoo Kim <iam@sung-woo.kim>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: fix a warning in devm_remove_action()
Message-ID: <69af1ff94c206_1a62c1100ce@iweiny-mobl.notmuch>
References: <20260309000810.2632065-2-iam@sung-woo.kim>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260309000810.2632065-2-iam@sung-woo.kim>
X-ClientProxiedBy: SJ0PR13CA0141.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::26) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|MW5PR11MB5787:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f6c8722-3514-4c73-f6f3-08de7e11e34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: kIN/KcxpWEa9tg2Ulk18+kczdj1p8HPUA/iPYfmvPlWEuEbYw4OClNyqB4qgbdD/ke1Dnfls0rrM/US1EZaTsGL3R1ZOKEq7W/IviQYrRMK0bpAUdvUNQ2z16ZjNK3HB55dkUDzGc6V375s1SL+B0zGiQ7Onmem+gsptgg67rh+ISxnyOfNCAfjXCpeFJMhmRRl6A4fgMx1QfqKhbys6D9h44/LCf69GdzaBBpkusxRqiHs6IFnHedBHZAzrUUdBwAO/oqEYRIqgucDe+k5GPgWGeowTOX0PUwnhMl3CQaKqwyZWU6LUXIYeB1XBoBlewF3Mh/eJTixYQtDwAEk0uXNinenKODBvOUD/rBndzvfPp7KZdoqIeZbe6HtEI8R7yvMGKRZJWFs5hnLYGta6rpfK3lyJF7W11Y3CPNYmL4/mKqAtjnlOd4UQEOHjEcBHE72oMLBHd6++kxG9j/wrwk6HZtwgMhl8SlbCYVbFZCwCqC75qjAXjUWSpEKLxz1GXb4XBmVaPhARhmeNgVomfUNTQvCEyoToZ5YpMYRWia6knqLqnzOscUBz/AKmFJmSo8EeWRGZ0MpKGUFf5QGrbQQkClgi7Lltu++kNdRjxaCUvHuyfU1yoFCF0q4DxqZeXF8BsztG8WmcCWwskkSodIFGA4UH8GlK4inj+Vybmspt1KOcL0LJMkYE8rmGsXA4E6liUfokSgB3xW4esOz/OyfpDYcsELAzxyAoCvan3po=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vUDTfqzb//3p3uoRrVsbJEvA+K0IKGBezmDQAOePgRoXgtzvY2FIn6Fx/hm5?=
 =?us-ascii?Q?UvG7kLQv36I+oFkwlM5oOqwI93gYgjy9Ya1HyT8Lv9ui5bdAWZlmKv5ySi4p?=
 =?us-ascii?Q?SU+p5hJw9HAQ9UzhM4+thoi+GxzKnSJB1ppUCdce1pjzYFxPm4tyP7K/rDNo?=
 =?us-ascii?Q?wv0OKDU34uF3XLWoqeptH21OVRse41Yk9dih3o9xmMUOu6nXp4zrLwsQYgUN?=
 =?us-ascii?Q?/QOc51++cE7s/nIB7ZFBdywKDtl4u+rK0ccc4/CAtcS06ifYjFcQx/iiMIX0?=
 =?us-ascii?Q?rU4AJ1OYthp7oXqNkjxXXEDOeEIsuZRBiUjArpVPSO54NLOcpP1JK6QIEjEx?=
 =?us-ascii?Q?qFPykt92KZPmxdkcpC3Vwy8NkiX1mLWNzbd2BbHR+Bag8smWQqGnPWiijByv?=
 =?us-ascii?Q?Xlpguz8zvkStZsipapTiWhM2iktvXouIeZ0zLVuu/2GfUi+LJUdbR4hHZozH?=
 =?us-ascii?Q?+IhkwgcYAHlwNegGFqNAcupAFaKmpUpZkU99nWPEk4B0jmXJ2P4/zrmeSuTW?=
 =?us-ascii?Q?gHtaW+Xsy1ieQrjc4DNbZAwibCB9dylxIWaTfVn1/PtTZdLSHMAx3oulLDuz?=
 =?us-ascii?Q?A3rT13hEzWfDVU2IW0tgFV/m1EYalBEQUcb0OSpJBPUHXpuLeqd7b6u7nOU7?=
 =?us-ascii?Q?1AaChALQ8rzsyAXhL20r3GL98eUsb1OtY8DSGr4sCa2KmOogXaeHiVyAQWyX?=
 =?us-ascii?Q?QlAI4qHlSfjNHl2oloo4xAjtobjQpkjpfM+4qJZ67y6bdaIrdiQy9+v1I/ys?=
 =?us-ascii?Q?qCD86Bs96wzaA/WLdoaf1uu+rshQI1gbWjAH8XzzgvF8wVxzcMod6IKRs7IP?=
 =?us-ascii?Q?L7IITYKhx6IxvS52KF9OWQ7G/VMqEStLrWAvHHiAwgued4rQWqjafrFxf9RG?=
 =?us-ascii?Q?2fNKp7RIBwgJ8BC8HL1MGFC3r3QgsZWannSsHls0LM4hKWbmKVjr662o1ms+?=
 =?us-ascii?Q?U2jyrEttJHbsKtKrTs5SPWOelcfijOP9+RzoP0udWRpOdluUCUs+isj+7v1l?=
 =?us-ascii?Q?dgC8QbJdMew8fhTixT9rj5gG0i6YY4LH6yjZpvd6C6E4+4D7qpQOHtPNoSuw?=
 =?us-ascii?Q?XD5dpQdEydDokKgSDvlCwU/QMU+jdBFpDd+h1np/sIf3N6+9gUt24C85ZCPw?=
 =?us-ascii?Q?mG3lQa36MuTvF5nL/UD6yffl4dnWs4TF++IVcBN9U6T+zfCinfZc7//NpZDF?=
 =?us-ascii?Q?Rjgkha0tedHbw48Uyl5W2VA+aU+r9TIfTyd/b8HAnoUSob+VkXv+mmV+EtDh?=
 =?us-ascii?Q?me2WQ1SEHyss+LXlNh97GVFKX8gNK1ix7+jRoiv3XpxDuQCmKL71yeQX1xq1?=
 =?us-ascii?Q?8JxmIsPVhoXDA8XVQ70/iliwQBzrYngaFjCt9rUm1wjLZXLUSArXme3Sm/yf?=
 =?us-ascii?Q?josbw8go053y/uPxflktkehLlHNEgVhjNgKvM7FGkwM8qeOQrfUIcHkU3if5?=
 =?us-ascii?Q?2oz7PfbEuF1ekM0fFQahEQ/7jUwvHWPhtMBGNy0l6rSto1yJG2qM3HsfKeZm?=
 =?us-ascii?Q?DJMGCKqnCEPYrR8WADK9NO1TcQty/dsKQVE8qqh6/csihutBXXd2cGATerbi?=
 =?us-ascii?Q?67T3x1NZi718qcRNAnYpjRagZOtcl8kvSrZuN4f9cwmyLuVDT4IVTbIFQv1b?=
 =?us-ascii?Q?ESV7bvD+6yThxba7Po8rbC7pCKV21tgdXhV74sI9B1Uqo9uzwCX6naLEYEF4?=
 =?us-ascii?Q?NtkwPWDgg75l07L9iEQbaAx1mstzCW6bL7EEhlUAyzhNwXr7ejmI9OhrB0f6?=
 =?us-ascii?Q?ktf+diMEaw=3D=3D?=
X-Exchange-RoutingPolicyChecked: LzHUzHq3q4M+isKTmmKisg9MIQF10WwpH0GEr9t8i5mAbz8gFRlYbVYE6ii5s4hEthiBJCVJIylUOn5iN6suB3IeEAqJBNQWPuSwz2C82Tf3YKyb0BPFcOPGBJffuP9mX8Ew0gKhm1JP9BpewNJi6yKNCu0zIorNjNkoqNBIqVo5utwGJ8Yg+E/dUFAeZxqkizX+13BYdO1cIBLr91AYSXGynBU53EZSxQiK1/fYHKtgoiMY4I3Qw9Xq2Qx7QW3InA9CTLGhsnw/p+NkoXpS8NoKB39W8ydNPVwFBMc4I2QvjtcukWOREQXcQHMuRFL6JWgn2Z35ry+eZDVNSefudw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6c8722-3514-4c73-f6f3-08de7e11e34e
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 19:27:22.8479
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RDuwYTDLiqDe3L2vb4m6iP6C1EWzkrl3ksL1ApHpGrNlBHAfVgxYSQqmYXCTkTxT4Mxzza7hXcA4luxl1B0+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5787
X-OriginatorOrg: intel.com

Sungwoo Kim wrote:
> In the following race scenario, devm_remove_action() can be called
> before devm_add_action(), triggering a warning because there is no
> action to remove.
> 
> To fix this, extend a critical section to embrace both
> __cxl_dpa_reserve() and devm_add_action().
> 
> task 1:
> cxl_dpa_alloc()
>   __cxl_dpa_reserve()    ...(1)
>   devm_add_action()      ...(4)
> 
> task 2:
> cxl_dpa_free()
>   guard()
>   if (!cxled->dpa_res)   ...(2) pass, due to (1)
>     return 0;
>   devm_cxl_dpa_release()
>     devm_remove_action()  ...(3) warning, no action is added yet
> 
> Warning log:
> 

[snip]

> 
> Fixes: cf880423b6a0 ("cxl/hdm: Add support for allocating DPA to an endpoint decoder")
> Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
