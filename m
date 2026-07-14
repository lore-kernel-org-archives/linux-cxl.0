Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B088E432E6A;
	Tue, 14 Jul 2026 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784057386; cv=fail; b=UbaQGfMbnbrDz2MvLPF5Tsfqe0FTfkF9t2ZroLw/oio2Nq0lfUXZVJYiUvxdT/ubEGLmzgbniJxi+p6j+tnKfF3B23e5QgqQ1GnMyTC/iYmrCRa3pw9noR51hYKrWMT7gZmDT92Wc+tpevXZ/uEeRc93jSFcF01PevIGPOMu3qY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784057386; c=relaxed/simple;
	bh=LoVZQkp1BBWwYsb008ISt3aCiNIYSA/NqA7cwCQfoTU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OrwJcHYuyrZMm28OPoGokSuvmPzV15r1J2tbYzMoaIKk5YzP44F5lRarc8uF7vTMABfsLQE8ySdO/yVgn2UR4svF5oMH3iQdTlJrPoMi+7V0FdmcjLY+YdAE5iIdzgH85LTzR5bt3NJKaOF1IdYGa5wBe3j7q80+ATZouDRrlv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UJw92r2l; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UJw92r2l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784057385; x=1815593385;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LoVZQkp1BBWwYsb008ISt3aCiNIYSA/NqA7cwCQfoTU=;
  b=UJw92r2l6VXw05e2mzzD5I4DkMqJqtMQe8fSv/iRhprGose84+P7+Tzz
   lypV//yS38P13XSmB/L6wN0A+sIOmXHMU1aDz99hz9qYSRK7T+hmWpHQy
   7kESe3i+dJMyaokads30bFIcGpHeSK7bGP/7iNAKv1pORrpVvS6Yni66g
   PpyzXfWD0aTHHEkMVp1B+UJ+x22wZEuvibPH0AAgb3TrOXdCGkznROFDp
   n19rvtZkgExHjE3fi0z7gAvY1J+ydqO0k9thXgYxUTbh0M7MSNio7fQ/z
   Zt8GX7BKxu7NkGhdeQbPN12/JoPLoFd24SYTo61eiiduRMF+1EY9brBxC
   A==;
X-CSE-ConnectionGUID: +h4yfzAuTjeg/zC4RcPdvw==
X-CSE-MsgGUID: mZT1h1m5RiexC55Q8U40QA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="72212924"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="72212924"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:29:44 -0700
X-CSE-ConnectionGUID: 7k0y9CERTO+Z9bOl10JLpg==
X-CSE-MsgGUID: 8cBHFm3xSXSE6LK8bGtDRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; 
   d="scan'208";a="254829535"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 12:29:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 12:29:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 12:29:41 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.44) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 12:29:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yq+d5safy1ztWvlhqtqpY/9dOa898MkO60NGvPAUx8vPL+wUeSnznHHPEK6N3+9h9qtoTYhj2PFZawzeUtY1XAzYeq6LCNvmmsbUGIrSFj9yUwspPSpgdZIQfxMG720Y1maV6w2TcQkZJwJpwE9+ujIwSSx/jiFQRJQHc3wOtzjnqjb9RCY8ulchb5W+wCNoMEht4lUIvxljb0KB1IcaoJD3LMPE+Hy+XoL+jZCrLYfhAVjYCM/eoxsVT2qSKmsgpF0G5CYfT+O5igmYjp7lmQHM0+uS7SHLQBvKWmpnFMzVbOo/g81M9ua+qzL2YKz0O7UfILFWUzmPGhZuv5rrdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qy0Z/YsiN52YXRO1vhGDAQkgVF9EXA1eutr9an1sC4M=;
 b=j8++jbeookTWPUqGSUK0Qw3FT2FxhcHCPiZmQbxUd/ugqEuayA6NkcEx9saDiHGEPv8/+osZInSH0t1oOFxUq6Lc6pWDUao01cwDg1C5bjyHK68GqeJFBJ7vLzSfpGIWbUoCkCrNgMPFHls2Avmu7Xgz6BPVPSezCu9odJlk6gR9v2FiwL0HKcqpnPiNLkeFI7nj54qyjyScNgjnXH/Sgut2szWTbezzvWrTLext9jRI/LsfmvaTRuzkrB0xNejYs0gsYph2I/rxGsqolZUL5PvLEyAqbYvBGqLG66wMt5fw33mnyCab+Ssf9dYq2ro1QYVvxDf+Ao/qsy+7+oFgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DM4PR11MB7208.namprd11.prod.outlook.com (2603:10b6:8:110::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 19:29:38 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 19:29:38 +0000
Date: Tue, 14 Jul 2026 12:29:33 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Richard Cheng <icheng@nvidia.com>
CC: <dave@stgolabs.net>, <jic23@kernel.org>, <dave.jiang@intel.com>,
	<vishal.l.verma@intel.com>, <djbw@kernel.org>, <danwilliams@nvidia.com>,
	<iweiny@kernel.org>, <ming.li@zohomail.com>, <kobak@nvidia.com>,
	<kaihengf@nvidia.com>, <kees@kernel.org>, <newtonl@nvidia.com>,
	<kristinc@nvidia.com>, <mochs@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] cxl/features: Reject Get Feature count larger
 than the output buffer
Message-ID: <alaOHQExFazwswlp@aschofie-mobl2.lan>
References: <20260626104102.53892-1-icheng@nvidia.com>
 <20260626104102.53892-2-icheng@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260626104102.53892-2-icheng@nvidia.com>
X-ClientProxiedBy: SJ0PR05CA0171.namprd05.prod.outlook.com
 (2603:10b6:a03:339::26) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DM4PR11MB7208:EE_
X-MS-Office365-Filtering-Correlation-Id: d2de63f0-9f31-4cd3-6db8-08dee1de3e85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|18002099003|22082099003|3023799007|4143699003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info: kcbcEMj96N0AUx0LUQwJjGFfhF1WvnqHMQJkkfO+dqDvfz3LAItehKen0/9j2lwqS7mwXSXXY8rH+cnm8+2rFRq2bLuA5VTLTPpZaeQQTqN32c7yP08Wipo9gifQEQN9kKGb4nAtUc1Lg5tflhwmTs1D8LUO8C8iJW4Up40N8vevKA1Z5qul62fJfjEHReOhIbu/Bv7uTxWAXsaPKqA7MvIESBqcP5map+UFNa84nYQkTcA+meB8Yz1GUrgFnDaYbCyIdCadkfVwb9CCc2STU3eiHDU+A2zN9WlGIe4zkUCUFahyovCUUUZqvKd0CxyYZ/mKZEQSIDTNXzeeNU6AgxXB16k3jFsi3G0LNoHcizFDLk+JJhz24x11NVFv4mQOUOhajI0vEAyFbxL4Erf3RkLizrsM1zB1hhOGx3pJegIDQGKcmowIUQFDmH3KB2h4xALpZEuZL+WEUT4hCGJGAYtByixXtIbq3loYh6G2eav+CX6WFDrlkH6grF1dAw/zZS9pYmvx4Eb6nKu29PvA8LLr0fEmsfJlLV551Y5WA6NPVSxXyvoia03HUKv1h7C+DFMJXNcZaZ6jE18RLUt0PnURwe2hWuEA7UMh1W6DSf+9JEkbs31tmhSs12npJIvxLovdYltFVC13BOQ5K0HZr8PWo2iAsUCUXYaQ8N2+/bc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(18002099003)(22082099003)(3023799007)(4143699003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EJR39RWCuLWStyp+lAoBng7N0vZcRPdyf3n0G7JlfUoK6gOx76I0tg0FzJeO?=
 =?us-ascii?Q?8hgdVd04ZtpykfdDZY4lL0V1Lys+23ZZH/5aWAeeyc7K7Arngsf4q/6CVc0s?=
 =?us-ascii?Q?N3JKPOryX+s0YTL+c+fDQyB2vTbCwK6SPogwF2/EJA+/zVQliyVg8MRmhz+c?=
 =?us-ascii?Q?T2oTy1/6I0pDc2fXTDGCLNt1di/s0wLYkfFoWIWKSgqQyfbmKHTRDXdij2U5?=
 =?us-ascii?Q?F58h59XcXXcWd4ujA9vMT9AOu0onYMWtmMfebYaEvU69LEeQWhTduqczamNB?=
 =?us-ascii?Q?y5Tqj6R+2u7zVpwVxeExie5b5sL3VTmqiDV28nMaIrG2zeLUMpO7W/bqy4Zr?=
 =?us-ascii?Q?/AHTRHG0wVapaxixfjRQYyBoP8KUviRuEXsAD6Ex7iyvYbzqjazpt+/lHvfJ?=
 =?us-ascii?Q?ZRBNuEPPXuuOFa6+jbXCQxUg14uhzbgjwVhykz6FhYfdCJjshBC08c3BPSPg?=
 =?us-ascii?Q?uo1+MnkvzKMYSnvLAShhKu/lMr8bL+4uUhAmGMDnx2P05K/d93HzhuX9TuPl?=
 =?us-ascii?Q?0DmU5K0gacgG3Uops0p+o/W8KLZZZGCnrhi8LB0k6caCLEBUH27axISUycWK?=
 =?us-ascii?Q?/HRywWLhiLBvxxkcywPUSFvFFLZESOCWUVXvC2IbsNB/GxvhwluOpfXW/iMm?=
 =?us-ascii?Q?9i+BrXUHwts23j6SH9QqyAQvZdbnxGO5avJrMUlF/XxjcAJHU9lb92cyH6o+?=
 =?us-ascii?Q?35UPFd2nG/WpuYSTbd6LOT3aesqrCxeKUYbT3RoM5PczqHI37gTZRFFjCvVm?=
 =?us-ascii?Q?WMCLH5VpXRMj+4TVliL+DM2TrqrRxDKXwUfdBqn+zhNdi7TCLxqpnOEvug0i?=
 =?us-ascii?Q?l+jESJmUflK1lSzpSsgJX/J9TV2T+Zeoi8/2XsBoWwyEy3Psd8nApwwKnzXy?=
 =?us-ascii?Q?ubjJTKv+MjGZNpBELqcUMzkLjP+rGinNtVT27eA8lGEp8mc1K5dBdFw7BbIG?=
 =?us-ascii?Q?Pgsyy4+4N0JAFkxO6iTHtARf8zQuY1rfCFjptSZFxCxfNcR1TppvdGTQ6grU?=
 =?us-ascii?Q?E5kvHZUcjiFRGMny7iWwotDCdHNhNUHzGdKIrZw3nYVlsDJ7H+kL+/Di1PAn?=
 =?us-ascii?Q?OV5VhGxZu/PlqO8vP+OAfLelipZh6e7ebNyZkKNFDQw68Ewsspc8ZrhmBb7w?=
 =?us-ascii?Q?Ui4d8ALeUZ7hzHGDmNHDjfS73Y/HO+l6IZqqsxn+rPFGjjXxeSn0+3nbSapj?=
 =?us-ascii?Q?QsaOfyoWVacxavI2zgO3QwSbaMxJrIxi+CK14tvzGPwWxR0MCrdBp/B532WU?=
 =?us-ascii?Q?iH8J4hcDpbR4lDjbpK8xdaPSA4l0miI+9FpTV4kVsNxQGnRxfziaMt92AvvT?=
 =?us-ascii?Q?p0VBrq/J39i+L+uTHvEgRK2p/HL6NtZgaFuJuWqBMqyH3ADsnIVRIxcgml4E?=
 =?us-ascii?Q?LqhPzFK2Co2bKbWemGImkFMwQ73ffZ3u2o4Ll/h0+RjSYKWjvpkpRth+SG8l?=
 =?us-ascii?Q?33JxdMDYUMx6LntCJhz/cw6liV7nldYsSXnqJJGsHVlTAipybhQPbVePiqEZ?=
 =?us-ascii?Q?FmK5JCMkNfsJPM5URPgk5Qll5nUAOpOhtOavUcgvAqbEpUPeEBi8652BKgho?=
 =?us-ascii?Q?GPN6H5rz16B3zBMsKMf66Tgp4tBg7Y3voQNzq9KZF3Cpv/MSj9o8WgqAkS7d?=
 =?us-ascii?Q?oGXWy7ge/vYcqdF2ABjOdKlTDOwQt6w6r8ktKf/LWJm25K8beXMukdhcNI/R?=
 =?us-ascii?Q?c0rSy8iy6ph2mXzHYAVTp+DxdfOz2WLqP+n8HI/P18A9tPCwtv0URrYf7Dsy?=
 =?us-ascii?Q?dR/Dkz7yR+dfKymKAR8otBzg+YwsDAA=3D?=
X-Exchange-RoutingPolicyChecked: ZVyF7EvliBpKEjhHpg4m8Dezd2lIv4u2P/dWfrv6XE5GMBGj4Y3KO6uUGV9chiLbE98+Z+5sn9xOgcXfHW70jjSLP21PRKDLV7vUmFFLHvm14JVCuFMl/nlGDbT0o6td68R0PfdYlgbjVnm4SmPhcxpHAQEQCqhYic2O8DQnsKwx+1NNchQ1t1KtrAEB5PlawrTumS3IjGrzczlRFKcwpgLWKF9Z9JeQggZ2LFXLvc8SMIpQCLW18ZD2tqH9K4emW5CTMTP3YtD0zKIsVoNRuyHZjHzvcF5Izff+zEP4OEVJTdYGgyWEM7j6sBdz8dXjtpjMIcpF/SnBGMDrRb2ORQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d2de63f0-9f31-4cd3-6db8-08dee1de3e85
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 19:29:38.3256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HAAS4yDYCY90j9subAi+l8wbEupFq628dzxmTZ0re2AcCr7NnTFQkb+nRdC1ZG9+hGkcOcl09xCybH9PdDVRFC5tlJTsPxbDadsYIxGyFO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7208
X-OriginatorOrg: intel.com

On Fri, Jun 26, 2026 at 06:41:00PM +0800, Richard Cheng wrote:
> cxlctl_get_feature() sizes its output buffer from the user's
> fwctl_rpc.out_len, but the device is told to write
> cxl_mbox_get_feat_in.count bytes into rpc_out->payload, which is a
> separate user-controlled value. Nothing bounds count against out_len, so
> a small out_len with a large count overflows the kvzalloc()'d buffer.
> A heap OOB write reachable from FWCTL_RPC.
> 
> Reject requests where count exceeds the available payload room, before
> allocating.


Reviewed-by: Alison Schofield <alison.schofield@intel.com>

