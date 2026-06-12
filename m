Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A7238D52
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 02:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781232295; cv=fail; b=D/eEjDtCGbfj9NylqgwFNzAqDbyaVQggve3B7FYkH/ncS+qIrNzwEeaTrtv5NIY3P0nR4Tf0c7nH5J6ECDtlc3FJKG40AJB2t2sw48iMLTk6LJgvW2TNrV7rOxvue0gSFscSDABDjnp9DYRJyBnI5/Xvtx33uBqFZWOQKzOljQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781232295; c=relaxed/simple;
	bh=m8cgACcV4IoIVrxS4xL+yZ538U+JUp5hgfHKbvDWVWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ehgQSKzbVVIgCkF0k7gECJeHmgzamL2sUuM2qejO4FjqPusHlO2qAao+8ERr8x1OX/RleQvYOFYDWosYRDlyvUpWlmzZOV6SS1kdOHJpvNfYFaVaLJ3+MuPRjcr7AlBghTT7yNahq3CQ7+4XrNdSlbqRQr8GMxuKD1wgEZKEPVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=is+md4n6 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.46.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="is+md4n6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QqCWRHTgb0SW5ULPHYpPR7LiE0vRmh0jVOjNVKVcfA5WHWKtz8bRm0xyr6CaLOptRVNCVnyyQC88RRuP2QqC9pETIAWpf8l+Ey6Hau5pnRdryMOofQ8eNIRPMGQ7soNFHe9huMltupjU4SNrC9L8HthmNrP6eTFnEjBGfWcFv33nU3XWAwHI1kA6KTqh0GwpotsWJnmcsW+LkNOt/fxjW/6o++S+9ltfZOjgRyEJfQn9b6t7DGQ4mj/Cu4+SlCeTIm3KkUYsQ7wMowQrwP9fV29e5PbEtF8VgzOm8mbKQ3aGFJcUsBhTF8lx5xDr8t5mn8+UeXA2ERFMTR5JNpBpbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+fwwinUV0hviTg37YcBQEha5UgoaQQdEi5aOHYcp2+0=;
 b=uN+CnhoMxPS3OiYwq3h4N58TjfgkxbKjxSwT+ChHV1iNVbJXNPP5dsgO7Yd8/mz2vsieT0nZ7olIeR6ScudB9jKgca8kaf+ZUhPyoKm4EeKlj8c0Qyy0SHn01RSxnTUhZk+hE4W1A08MHcJvM/6l1oVSDgY1ijudpQw1a81Axl8Ly0D/Llaq0/jPxs0n+rzGBlvMkyZolXsTw4xJcin23dr9b8dZPAY3PdU1EkDld12J/9FBh/kJ+n7xNRJ2b7YcMQcrMwX9o96DCRRHmt6RXI88icvCSySOPrrHRhqdTy0EKd4gEiJ5TMNxS8UZHeIQVDx7vOKTQRbU18y/wvgmXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+fwwinUV0hviTg37YcBQEha5UgoaQQdEi5aOHYcp2+0=;
 b=is+md4n6h2d/ju5TkD9cKZCwpq6dRpMwzOK0XxUquNaQR3tV+KYfkIDYpTThxuFJB8gNbuJqPT4KfSlDy3m8rp5d5THiK/uKI9xybEYkA9ZsyObeGn3Pa46x4Cml4bmKFXdtjdgLwLL2Lded/E0bB7kayb+BbDeVjKF9e9CoAdk/G+b8gIGNq4Udps6BJLX4iBGZAc+xI19Nf4lvK08ENc9V1fAhLNAHQFVKdKLXCb03Xw3v3d4jXKlm2pOzp/vd0qWENLRKOeOcgEPxBz+EaAQnCh0bmzpJdJoLRgFJmJD3rj0QwbeTl0GsNhiJFE6Hwep7KU8k7JOacunO9tEqUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 02:44:50 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 02:44:50 +0000
Date: Fri, 12 Jun 2026 10:44:44 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 6/6] cxl/test: Add cxl_test accelerator driver
Message-ID: <aityLD46iQR5I6B6@MWDK4CY14F>
References: <20260611234409.256765-7-dave.jiang@intel.com>
 <20260611235806.021F71F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611235806.021F71F000E9@smtp.kernel.org>
X-ClientProxiedBy: SI2PR06CA0003.apcprd06.prod.outlook.com
 (2603:1096:4:186::14) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 3445e414-cbb7-443b-88ab-08dec82c92d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|56012099006|11063799006|4143699003|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0Qp0viWh2HyqiWDoZVD6ylAybWx56rCs3FEKQGatlaZX4CQKUhmUWFKBqMGWjGrsEeSW0OJ4EMUV3omYiVDyBdLEOVkaiYSrtY/730sjGnfyfTKJygWFtcuIFvfVmtD7evVLVlVxu/w6sfD59uOpyRzZ89fpUUrZM7BJRUeKTigT67tXqHHrWffEKti+oVljGVbv4ZyjQlbFodjKh+Gl6PeC1CZhyLWXS5YlN93JT134xjYngyj95TASq3MfpCJ9BzRIyHD5rYpuVPU4hEhYGZYTolGxa6h8M9Z8Elhr1MjYxJrsFrgD1MPbkyl3SVSq/RcTdsUjEL3m+BHaDGN4tTwRKpXkwNPS6lCmEgihH8QXkrcmH5QGc8++2ZGA6O3crK71bzxJzvRvTQG9/oi3qtcGaipzO1YQ5uSlVEHmZNPUW/jaq5cwO7w28NQ2JIIFPeVv5XiNF0gwR21G+JzawOFGJMGzsoVPFZTzLZrdoUgNpBK/lt/bjXkdYvT1Q7Y6W+HYugqQ04it7dY7WLya18SnGT/i9BdF1wwDKliguAZxYcbrPXS/FAqpB92m+DG+hDnhSwp4hT6GFjUUcyLlvxMVC7ETivGFPajH05soQIrw8xD9nMZ1JHZgBUbdlLeuTbx4f9xJC0PAAfd5ax5TyDYLP5tXFfyNnBBJazvJQa+DfQPlqKkLFN5mH52qM7u4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(11063799006)(4143699003)(5023799004)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?b67oq6YRSsbSCPPCHhB62VKCreGVpnHCZl5qZxJgeOFBGfEQKuACCqb1Zb?=
 =?iso-8859-1?Q?GpLWt7Aw8lTtsMOooLY6hwEYFk76IRyol6MfFMYmohn32SrkQ+Zz1q4g7d?=
 =?iso-8859-1?Q?V4kie68ZKrfwaOABUsGQ38B3AdqMZkAq49lhlcRxm/uo4GVo2UGXGeJZw3?=
 =?iso-8859-1?Q?zuRAk1dJVU/bbPu5a6UgjOI1HlGuezOThKFOqXDL1xZXrAdF8D6y4EdJLG?=
 =?iso-8859-1?Q?dgkdJW/+zO9qWZE/kz/Sh4joI2cqnaLlEbrACLM4glqSM8NL/xVziEj00o?=
 =?iso-8859-1?Q?V6mdU0aCcOOIIr9GB0ni5FqfIHBKk/tlhHYSB8D6jykZ4oserSO2Gr7PWl?=
 =?iso-8859-1?Q?Pewx0qhKL+lJIG6CA6mgyL3T83S3mX7cx20PJm2eZNVBBdqxehUOucfpH4?=
 =?iso-8859-1?Q?bi20YafTmyBDCda09L5twflvMWFKEDroXiAic7T/SNLScf8byRBwtd9UaD?=
 =?iso-8859-1?Q?LgPKTLsFlAnyuX20sVRbm1NZc0cbZ1JwcE7C/bGSEQvGqb8++xDiOKayS7?=
 =?iso-8859-1?Q?BLq3e4s5rH+sSy9PeGEjyA42argE1xK35Cc4+sei/mxthkm9t8hrf+DxIH?=
 =?iso-8859-1?Q?mFatCjMh3IaNUSfKbN2m6ZH7+1sKsJxiYYR8vFKyyBSpMHpke8ReHO6dZy?=
 =?iso-8859-1?Q?stbLYgQvCY7/2WuR5nMoLW+zMwQo4qm8fzzLVS2t2x9b8bpJwEZpH61PBU?=
 =?iso-8859-1?Q?j9ZiLNigAob+W04N/Bp/dP6+EzWIauastZHM5cj0MF9TjqQYa2p3mpBzfc?=
 =?iso-8859-1?Q?K8iHyopGj7wskDMe5qm/y8L+qpKPWX+/xWDqqbKEUPt9yxYlDZFANTnGNt?=
 =?iso-8859-1?Q?hLFoaLIQ4//DfYSbgDFUlXJrPZkNvcmPZAdwIkmDaqPRuU3B87KOXwxFwk?=
 =?iso-8859-1?Q?1mY8AGuyjxD3DhyJXbqsEuXlfx+m/0oFHxxobAFlT1TmLUOnLKbNJahrJn?=
 =?iso-8859-1?Q?IJtKBu6eq/VerER+TVyyfc3U6bCHvn0TBWoQ25uhSRkvhpIodVFCS+8lhF?=
 =?iso-8859-1?Q?gQtf0IxvxTkXAiYH9C8iF7MhFhc2S58IUrFg8c3Z6qBcrxJwW6YKjmpyXA?=
 =?iso-8859-1?Q?I8iNSCoCX+i1v1WsAmJC0t238F1ETk50uKRZ+qmGd/AGCWmGedLEbSigCx?=
 =?iso-8859-1?Q?Yh6hnz+wnFoIbiUel+5CItEruxKpyrkIhVCYZ5B9XbUvyPU+apeqSmWIKP?=
 =?iso-8859-1?Q?xa/ATaHqdeIfrEBs4TrH2B5hudW5a26abdOJlLO+QcbEOkNgKoPd2sPQWb?=
 =?iso-8859-1?Q?hkCQTvigX9VNyMiuZr5ZSUWY/HRbFhkIfwCPiycynNIeiPfyzCQNf+/d21?=
 =?iso-8859-1?Q?TllUr23NV3BlHTXl6G8vijKR5VCA1cu4Zjt90p0oG7w198yKIuUaIHVKie?=
 =?iso-8859-1?Q?sMG38XvPXpSRs9QWgGMnJm228a9P82HkoED3MqhuzV9Gfqblp2S4OrsJ3L?=
 =?iso-8859-1?Q?2Ir8n2sTFzLTsqeLJi5hNyAQRbw0jX00uw3BvVoeFIJmEpm2MkpI4GvARO?=
 =?iso-8859-1?Q?G+VkD6ftma54kjmbG4l9NFv2e+3+7nm0EmtKoBC4aNdZfQL32wUBKwzCcZ?=
 =?iso-8859-1?Q?+iCuT5InOoRoC3EpRz1Q0fILKgjLjNIbGR1PJdF8Guuvo0dArUvjIWP81K?=
 =?iso-8859-1?Q?b4VYv1tcPc7YE2PkOfCO2lt68blQ1nhBq1MaoTEx6T3UGL0rHZZFnW0OqH?=
 =?iso-8859-1?Q?PjjIkh9si1qKd2Wq7g3/5rtPpuJaJ6Iu5zeP2/op+lT3DZh9JkjK9jT8VO?=
 =?iso-8859-1?Q?P8BwCJMYaGxQonnL8T6A+kA1jN2Pmtfpb2spKDQnaQjphDVVcBbnfIPndA?=
 =?iso-8859-1?Q?6uDaF4aOug=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3445e414-cbb7-443b-88ab-08dec82c92d2
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 02:44:50.4924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVhCvVtutVYXzqRPaRRpxMCX3zz+ykVB8TTK8CkcWQVUyTb90XMjx00NGsj9Q1svFDv8gGMXggKlo0FeWqCtYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749

On Thu, Jun 11, 2026 at 11:58:05PM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] The patch invokes non-existent functions `cxl_set_capacity()` and `devm_cxl_probe_mem()`, resulting in a build failure.
> --
> 
> commit b886732115c0a94e1bae2a16b1299055ba5c99ea
> Author: Dave Jiang <dave.jiang@intel.com>
> 
> cxl/test: Add cxl_test accelerator driver
> 
> Add a type2 accelerator mock driver for the platform device that
> simulates a CXL type2 device.
> 
> > diff --git a/tools/testing/cxl/test/accel.c b/tools/testing/cxl/test/accel.c
> > new file mode 100644
> > index 0000000000000..9c8235f9d97b7
> > --- /dev/null
> > +++ b/tools/testing/cxl/test/accel.c
> [ ... ]
> > +static int cxl_mock_accel_probe(struct platform_device *pdev)
> > +{
> [ ... ]
> > +	cxlds = &cxl_accel->cxlds;
> > +	cxlds->media_ready = true;
> > +	rc = cxl_set_capacity(cxlds, SZ_512M);
> > +	if (rc)
> > +		return rc;
> > +
> > +	cxlmd = devm_cxl_probe_mem(cxlds, &mock_range);
> 
> [Severity: Low]
> Does this code cause a build failure? 
> 
> It appears that cxl_set_capacity() and devm_cxl_probe_mem() are not defined 
> anywhere in the CXL core subsystem, which would lead to unresolved symbol 
> errors during compilation.
> 
> > +	if (IS_ERR(cxlmd))
> > +		return PTR_ERR(cxlmd);
> > +	cxl_accel->cxlmd = cxlmd;
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260611234409.256765-1-dave.jiang@intel.com?part=6
>

This should be a false positive. devm_cxl_probe_mem() is introduced by Dan's series.
cxl_set_capacity() is from Alejandro's series.

--Richard
 
