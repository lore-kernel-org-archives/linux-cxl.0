Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BC4232369;
	Fri, 11 Jul 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277810; cv=fail; b=AzIjAdiKAloKXo5LRlRR264qyo4CP0R0EM7XW/txL7JH8Ce/kagKzLY9Ye9dv5cmxujxnC2aZoRuIq2T+DHtMp4QfvVIMZvORX/hAQwxSaHRP/ZoLXQwCG0PSn73zSuXxi978lA1HdeLNySWwvsm6uJ/T+n0Pxr9L02JX9SP2vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277810; c=relaxed/simple;
	bh=DzEOh7Av0d26HjuOy37ZeUxSUq5Ef1syc0BYtY/9y+w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WL0kvC4wOVNfcBBSe6zbZ0CPz0VN1i/9dKqaeSiwI2Xtz25ucZ+QcW+7VSLKdMZmfLtrX4CWsfselqpj3+1DzBaqqfPv5/Vh/1GW3Qyb4NOz76onxORBYX9czyJsZNx9J0QqK4zDGtVILwDZyZXWnDO9k9dM48uGUzPhUmIjpdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M4uE1TmI; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M4uE1TmI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752277810; x=1783813810;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=DzEOh7Av0d26HjuOy37ZeUxSUq5Ef1syc0BYtY/9y+w=;
  b=M4uE1TmIIvpGuoJE5fnbWXodm57YNEobiwpn45gBlUYKyGpHOdweN9Pl
   pXPjXU2dvOc4Ay5iEIKzGrTHS82C1857zV2DhRjQLMcKCXano0LE/4efc
   N5yKPoBBRIaHjHxldeRu0g8BP6ws5Id1a2fyuiSWKzFwN2CM6hgvlH64m
   DfQo/Q+uhSDM79l1/fAiR/IspTD3lolUNt1cJawQEcgZIfQFinxdOb9Wj
   g+DLbgRhbaTOsLVKsgGG3B+/1usUEdAPJJb8ZSy097NN5yWZYHtpfPkcv
   0rK8NBvXFGQHdKiJcDtKzM8zCwvWt+rXMUTGXG7FU+eF9uSs6oKBW9dZg
   Q==;
X-CSE-ConnectionGUID: A+F3aGGcTQKo81erDX3q+A==
X-CSE-MsgGUID: 3vWx5UjOQN+A8AHCLkCd/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="54448336"
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="54448336"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:50:05 -0700
X-CSE-ConnectionGUID: oLJMUrGdSeazFF19/BSlgQ==
X-CSE-MsgGUID: Wi/Jkh8vQ/iZ/0AAd8tcCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,305,1744095600"; 
   d="scan'208";a="162160575"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 16:50:00 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 11 Jul 2025 16:49:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.82)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 11 Jul 2025 16:49:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgdvLEYrhQN/2hfAR1IkOph8FkrmJk38WT4/+yrpv8Rdn+xUFyNen7aTc3zy0L98ZiXV6+bhg/45LNwkArugD+PRndcTtM7PD8xWXAgbai6J5orTm7oMIM2TZXFua7t484nvnZtVr7JDOSKb6zN8NQjyZJ3P7LaJySzYc3TDcV9GxrwHPwmw8HYxgjlt3TSBSDOTyXyfxhzZrrt0UbPBtc3zp1wWVdP4lr28HRTRWwoUBRxZIlmeNGmSfxIMsGHYvVa//6mQu4JqXsxZg4o7g997tbvnn7s1dVyMdKCqWtfDTkiwwoOd6FFffcbpIz0BhS2VYRk1ndlBh2dgDIZPeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUEo9vaeUs6+GQxNfhp+zA6lgYmsA4bticxv8dyxPGc=;
 b=l8jcFc9rTmMSgG4B8j8jEdXsIE9eJof4hSfoIhNdr4UkVR50QBIiexbNi0gcPoQmUdCa8iXVq46cic+P1DPkypZimT+P9VhbR1oMMq729YVVvy5tAMv6v2Q1jXZn0ZRovf2ZCBfzEsBpaQbtX36ajz7wHnqJS1KEkGkI5zkBiow8xh55y0wr1O1BIJZq1N3Va52GCCPAHAtLkzLX6eK9GwN7NEdBavalsvxu1J6sx5Arnm9YvdlNSEi9cPUa3nUeHkTjUcWuMO8eHsESrJHBaLbD788VUMJNjO68BUWsLuN/gN7vjovH2h0SOkxL7q2bxS0V8LZPHCzsGDxzN8Zk0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7019.namprd11.prod.outlook.com (2603:10b6:806:2ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 23:49:39 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 23:49:39 +0000
From: Dan Williams <dan.j.williams@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	"Vishal Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [PATCH v3 4/8] cxl/decoder: Drop pointless locking
Date: Fri, 11 Jul 2025 16:49:28 -0700
Message-ID: <20250711234932.671292-5-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250711234932.671292-1-dan.j.williams@intel.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0011.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7019:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e1981f-495e-4394-7a1a-08ddc0d59964
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fKjVbQYcMK5VvOmzNx/dD4PgrLjgwr20tMTq9RMNUfoME6w2dV3BryFfH8RA?=
 =?us-ascii?Q?/zjjGC4ynrbYLKpAuqBzsaLg6TL1EPBZIJEKAgq4z1BpsC6z/KS0wvGwTG7M?=
 =?us-ascii?Q?CvhK+n72XZPB1Z6GIWK34PPty3kILVy8+kL9gnhoYhOWdDS2bsQPmWsw7NSK?=
 =?us-ascii?Q?3NyhSF+xyBsiPDtsCzU92dMpTfvAR7+UjMlAhctf/khcb9WK1CvITk3eLwoV?=
 =?us-ascii?Q?313Weu4AHfxFrIbZGMR5fnPK8swxXCe1MC11gBDKeSsU6ELd7SYfpgW7CRvU?=
 =?us-ascii?Q?mFpRo04x2DCKw9e6DM5c/HiKP2OEHNNsxcLB+jbnUyYH9BO0Lym/BKCCfABn?=
 =?us-ascii?Q?+FEUPzJLX2zRgKZBGtEP8SAsWW74EyL7YcSYN5kO+onvZjmfS6qs/fZ77GV4?=
 =?us-ascii?Q?KLLRuTlPIHxucRKstWG7OgGzPZApk1dpsJYd8u1ESbreySRwpYNuQ4Wc1i5z?=
 =?us-ascii?Q?0BK1D3QxSuAH/zTjrilOIIfzxs5/UACQ82zKP1YPF1By8N2Zs2gPLoqEN2Zg?=
 =?us-ascii?Q?AZorOvcLVJQegQ0P3Z7YiwR9XlkZWozyAFz+Vz0e77kPBEmCs79F/pX2h7en?=
 =?us-ascii?Q?agl+vgY/qCtg7TSO277RThW2htaKata/G4R7WHjml7nuKHowBFEqm2l6pZGv?=
 =?us-ascii?Q?y6GsD0yFM8xbwx/Rrwo72be7xTExBl5LOi9oJmO+WRxdpQ82s4cj/8R8TKhc?=
 =?us-ascii?Q?RU803G/oruKzwvJm56KMfh4qxhUNtpccRBJFry1RCYZUSBhlSNGY2hqIHj+k?=
 =?us-ascii?Q?AlcFQQy6Me2HjEl5Sa1E5lTdf9RNNJDqJjKEZ1ygaumTCfS2SYTXbzMegGwi?=
 =?us-ascii?Q?RbPfmSAx6PR3xcpGQIdY87E2pM80YMsVhF3Uh/vjONICWChbnkykeqWgIBi1?=
 =?us-ascii?Q?acvd92k7yg4t/ZR7LCEExpMQLvggDHJgQqP2jIamEKGVQqp451n8xCQfQiDR?=
 =?us-ascii?Q?hgESNNeFyJvzFlICrXn1cttbm20IAd0wMG2FzWJ/S8/F0J7ZupjE7brrKa5A?=
 =?us-ascii?Q?H3ONygOlwSyv6DOCOTwkOgPpUgr5kAq+3BC4f2G7qSYNpVT4t6/4j6Y6roCK?=
 =?us-ascii?Q?Q441Vg8IFeV3Mx4j2mNTe3/RlqR9Fw1+XoV0KL9/neNt6O6nR2etdgDn7OLL?=
 =?us-ascii?Q?VgQvL6BduAbBFGfBbCBCuHJADWTLP33UKsB8ywqtx78/oR1PT4UOxF0qRMzl?=
 =?us-ascii?Q?h2nXA+y/gAjw7qsKHcWe/cKXN9QbPCqXtnBycm+8E0oZt8cvo2APlisLiSgK?=
 =?us-ascii?Q?Fir8dsUsyHA13Sgmjnor2r0T+vqXyg/HKzAr7SzEbYK5j3z1FE/x2oLUej1Y?=
 =?us-ascii?Q?3ywLAKFFVGw0TxV0DZr30fouOsYN9qiqldvCwQCcDWE43u8hr7BvyZ6P2RpD?=
 =?us-ascii?Q?ardQ3d1MgG0TGUsV1JGtaFDunwe9+fKXVpl4Phpde0GjDpuCmY2wU1Mwo1Oq?=
 =?us-ascii?Q?l370la/1z7s=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QiG/RIHrT9Oif9oFmUDyU8yP71uDo34FrMNhazBh29s/ZnrOf0V6DKDxfMOi?=
 =?us-ascii?Q?okZ84sSxRniEBRRfbNN3JR8X//8vgKxw+2t2hljYv7R6fRfIPHef/gdcnxON?=
 =?us-ascii?Q?VgO4Czse/LWT2ZbpJgDgaBMtkK0XNJTWAGqmdoZEpiIuP4JG/w+xBk6N/Qie?=
 =?us-ascii?Q?nf8S38ul3ox0rhDrQFMrp7MygZ1kE9BcY99DQOzCvxaKJvw1i4YY3NswK309?=
 =?us-ascii?Q?B+ccInft6s0yBFqYFElgMQyjL6SUgDwTDDubunGelJxr1cOi0ec+UMlfLIXv?=
 =?us-ascii?Q?6I0W00PtqU+b7Ij9Hx4VUODqfktdU3FrYSTjpAc96H/CL/l1yJQxHUVLKHWD?=
 =?us-ascii?Q?FjnQjiDmVjBOdLYKpLyKFQBXXjdSestBSjO5rdfy9PcpQ8wsIrvBU5mnIsgI?=
 =?us-ascii?Q?9vnDmZFy5+7iDVvvJXiLHwfqdlZXRSWP21t3Cokz5ISlf/Ts7cXN75SfaRWY?=
 =?us-ascii?Q?jYbx/HC/pndIjGtJ1HsphFyB6+rF13GP1iInK2czRLas2iWdSYWfkXjWsLeE?=
 =?us-ascii?Q?zsy3G2KiyJahSzaJ/Q6ieqNqhpl/FlNaMuMsQpbDEEkzn5ZYQg5DSI+Q8DJe?=
 =?us-ascii?Q?kgZE92ztpj7svgCjC/AsXV2Y2ho28mRx3bYhKfNghRZnz0EpFLwiinaYI1qN?=
 =?us-ascii?Q?qwI8O9yvtGzvHyv6K+sl5UgY7kBjaMoiXWx+vgW75tCs3kIjEFeyvq+92apN?=
 =?us-ascii?Q?VX77ng+ALnKLCb3ZdfhGiCegqndpUonO6LKDev0MgtOew/m2FknQuCwzXPzF?=
 =?us-ascii?Q?ZE3E8AKR5Q+sre6/1JtKe9Tn9lYHAiNoRDQRbF9dLmG2RxSc68/h+Bei8nyW?=
 =?us-ascii?Q?27518qpsZNm/HN7w5jLhKHX83Vm/8Y2FppdyqMH6VNuU03iuWCeqMTLdcxAg?=
 =?us-ascii?Q?AQ7JHjQ/G0T1cergL/HylLbIJmVHWPHfGXqiq8685Jd4S6CJNEU/3ImZiDgi?=
 =?us-ascii?Q?X4A0mjj4y0CzvpEiEEGaoxr8aGxB705SfxAi/+CXaFq5AQ8NKKD4buRzZK04?=
 =?us-ascii?Q?5NYcXvcuteO2eDeWbvXj1Pqr9xTmqLfYIMuwtWVy+Nnxmcc1bnq8St84a5ND?=
 =?us-ascii?Q?8zXZ1m55qtSyM5TK8p5GivLVmraxcJ/pZz25LBw0Ed1w0YoSBXSt3DBO5dog?=
 =?us-ascii?Q?JuCCNgb3ZQFw31jLHLHMeOcsO6p5ptaAFSU+HXCRVpw0wC9TnxU/U/6H196p?=
 =?us-ascii?Q?AIYpGBADw8nQo7k4gAyE6JGhqwl7dyBRC7tOWol2twzCSBm15iz+TsUUfT/0?=
 =?us-ascii?Q?ESAtvfO1IyKQkYTsyzCWUmZ4gE2EDLhQU2E+Sp07ulX1on3qegLVnxInz1gU?=
 =?us-ascii?Q?pDJe2Bf/+73brAa6E0YOA6b1ncqnqgEa0N7mqDTNtC6d6dHZE3UpI/GwQi8H?=
 =?us-ascii?Q?g2aEf3NsI+vbeoQHLKNnt5udUnvC9cQxqEbghW9/Rb5yT8FUpCxU3bxc+jYQ?=
 =?us-ascii?Q?+ehNxqgXlGMJ8w1aUofFQmVHnDWtNj5EiB9MuxAZ9UfNpx/jJl+DdXi7Y6F3?=
 =?us-ascii?Q?Ilb8uoqp+h5qOl4DPBbR0pNaHnVtmSVUpcVLUoP6DJgFXezfZa+RGe7f3lZj?=
 =?us-ascii?Q?fkjiPLWy2r/pPh3N1DP08MPKW074Z5siuw5N4Q6HS4alCxvnpNueyLuKFbZK?=
 =?us-ascii?Q?IQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e1981f-495e-4394-7a1a-08ddc0d59964
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 23:49:39.1553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MvhPHmSMFvOMp+VDoKLcHK6dbBrDbqnPKAamUpSKjTr1c82UdZSiy+v6iecx9p/y2E6+/byCMzaiEE89umzDim0AO1m90XZgToSn0ZNYzw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7019
X-OriginatorOrg: intel.com

cxl_dpa_rwsem coordinates changes to dpa allocation settings for a given
decoder. cxl_decoder_reset() has no need for a consistent snapshot of the
dpa settings since it is merely clearing out whatever was there previously.

Otherwise, cxl_region_rwsem protects against 'reset' racing 'setup'.

In preparation for converting to rw_semaphore_acquire semantics, drop this
locking.

Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 81556d12e9b8..e9cb34e30248 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -914,7 +914,6 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 			"%s: out of order reset, expected decoder%d.%d\n",
 			dev_name(&cxld->dev), port->id, port->commit_end);
 
-	down_read(&cxl_dpa_rwsem);
 	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
 	ctrl &= ~CXL_HDM_DECODER0_CTRL_COMMIT;
 	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
@@ -923,7 +922,6 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
 	writel(0, hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
 	writel(0, hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
-	up_read(&cxl_dpa_rwsem);
 
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
 
-- 
2.50.0

