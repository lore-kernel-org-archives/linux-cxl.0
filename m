Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9754F18C923
	for <linux-cxl@vger.kernel.org>; Mon,  9 Sep 2024 22:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725921514; cv=fail; b=tA1xvz8E56KkfuM0DNXR8CG6Cn6y2wbE5cgivhyC3eR94fVw93k7riDo08Psz9FhmN2dkd2d4Cp3niqidNBySZCrtiYDd/RiJq8PqNM3cuMdqGjg9yUcxfvZv+62/8F78sK7Y2YK5bsKPHpPopwrT+4x8/I7jlfZrlbKf/NM+YY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725921514; c=relaxed/simple;
	bh=LIXiXtHGKqbgm18nR9zFJYqGGeTBkgwCNgrol964kGY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=pY00DT8xIH0m4uWksuNi2inPSmiIwWZhzGrnHfQrkBiHDCU8ZsnhfA6zhOGYoOzOSwKYAX/55+RogxbRENNlPRjkmFVZ/J8E/Z1V7bW1TWRexs74+/sllGMQujqGiPi5e2VvjHz+K6VCUfOWrBeg0uuC/mYEUR5QEx7PLsjlBho=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KAHLAin0; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAHLAin0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725921513; x=1757457513;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LIXiXtHGKqbgm18nR9zFJYqGGeTBkgwCNgrol964kGY=;
  b=KAHLAin0kk+KxBP0UGQrseW4Y5T5KaSUj8dPiPv7ZkIgxZmhTxoUeVtW
   O480Ye5dO9tWJ02iC3tKXymiubA8HSpq4h2HGnhaXIXk/gASbdSbO4MFO
   EcTTqRJ39W1Dfr3YYqkNpKc92yO1vne3SF4wA1oRpR5F+MapKPi8kYXPA
   SCbq8X1bWTZvIhZwr7Un4Mm7kEMXo8BM3cNyfSlo3f0cBc5u6kiSSv5gK
   1ww5Gm9ZcFAImMUatE+DJQ953JWcpPz8h7UQ54wRhBl8y8rGznEVuqYn5
   p2Aj3dfx7nmOhVLKBozVtwykj8cWx+1gj01RQSRtJG1AVa6fIex1cZR/l
   w==;
X-CSE-ConnectionGUID: pyqHjdJRTfyKXNy2N64rgg==
X-CSE-MsgGUID: R+nsrRLlR22f6icrjci3Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11190"; a="36025403"
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="36025403"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2024 15:38:25 -0700
X-CSE-ConnectionGUID: BbgH9Td/TLutjEAG3Qp51w==
X-CSE-MsgGUID: RhDPEvegSVCRgkw0mzBNVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,215,1719903600"; 
   d="scan'208";a="104275201"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Sep 2024 15:38:23 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 9 Sep 2024 15:38:22 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Sep 2024 15:38:22 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 9 Sep 2024 15:38:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I43/UWlLl6umUiDnJRBV/A2HkTahAGrFUDkfZuuViJLTIrPG0h2MB6TP85+mebS/DTjKHsAnQCvUwWbjJTQ1coubD1zWZO/aIT9adOGGpSC1J0K6bpaHPC8X01+nmeFbLHIvsoE1JgHzMsYDSq9lNM5j/fj6Gq2WH0UoyUUblaimDAvwcL68fcSZoHNW5k8s4Wll4IDQLQ5NwbxmUmBKOyTeibMWHLduF4rVxVJbaWXW+KxkDICk0ojEcRMvrasGuj2kSuVaxpl5/BwpAQPjhbtstjkeZZJFIIR8cjUpOhWZ+Gjp6MBuRDiZdzSSOL0uvKfVHnaAAVTXwRLXhtnTEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFX6ZOMBGFLYRzhBPqXIcaLqhJgykdcfI//ylDIDbHo=;
 b=Ha+wf/VcWRHhr4Xh/Zc9y01XSVy4GZeKv2BhxNvTj2XhNjYqoz6v5GPx8nfHSiHH0W2oEHHrtN8ud3Y3aFwJzbzQi5yGhSTXziSYhgZe8dvVRf5AiKoRswO1iwmIfMvJadUMpTHgX/i7K6YIpvYkw5NpVuw3WlekoiKIPjRdhI0jeNoyrg4JdtadEbgTBbbbdJzB4JpyWyYwqkwMpOMD1VQPbK9TLlPlwZoBOj2ftSMPSL5eN8AUNPgk2F6Z3qsiL7QUM5BRgpTDOk1VR9on8Oit4faC9GHXWbQbnISM9qm1XePc0887JLOthjAycPXQBAFSt0NwhHMjKhr2QguB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW4PR11MB6863.namprd11.prod.outlook.com (2603:10b6:303:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 22:38:19 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7939.017; Mon, 9 Sep 2024
 22:38:19 +0000
Date: Mon, 9 Sep 2024 17:38:13 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <alejandro.lucero-palau@amd.com>, <dan.j.williams@intel.com>,
	<ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>,
	<dave@stgolabs.net>, <fan.ni@samsung.com>
Subject: Re: [PATCH v4 1/3] cxl: move cxl headers to new include/cxl/
 directory
Message-ID: <66df78d4e6c21_3c80f229487@iweiny-mobl.notmuch>
References: <20240905223711.1990186-1-dave.jiang@intel.com>
 <20240905223711.1990186-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240905223711.1990186-2-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0197.namprd04.prod.outlook.com
 (2603:10b6:303:86::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW4PR11MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a8701a-1d3f-480c-d53d-08dcd1201a3a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cMHZg75RD6NQoQYmPBk3PDZkfvhrcbLhFbYZLQyxiEAmxy6Y+NJ3YNiDl+4d?=
 =?us-ascii?Q?7pnpfQtGuObcXFaSAwccDra/kkZTjQKwvN4+fN8SE0SflOnHmes9pHY5siDq?=
 =?us-ascii?Q?s9psMkDj2axIW7y/9i7bEiLXQBXEMASsRu8CGNGG2jufHGBcfHPf+7zOueYW?=
 =?us-ascii?Q?n7AZ/SR5BNL8AjvJohDCVLM6lOpMy8bJqW619cSO4wSJxpCYoswXP/41ez17?=
 =?us-ascii?Q?74RSP5Z6X8fXj4qK7qUXMP0K7ebmWTpIZhbk3WK2D2jdPkGA7lPrldh3LydO?=
 =?us-ascii?Q?FlWvXjq3FI4o4nZWQxvSTZy6B3A4B2hC+2z6Xrd+cS8h9sdDSF4nSNdZ3wOv?=
 =?us-ascii?Q?ifDHr4WPj2KtQyDPkPoyhUVgrmD62mNw2K8Y6QWeLNFPo8hzXgi5hyb2/XFk?=
 =?us-ascii?Q?WP3eCr6Ns1CdJIVBa3+Mx8LsvopsLMWFfhZaECNWgB8uHXgkwN9eqjakAlgi?=
 =?us-ascii?Q?GiWSgUj+rEiqKCON8/tLWsZ8CSwW6Wg7W8+YHicwF/KMrikBbstMxob7UVzO?=
 =?us-ascii?Q?hR9E77LLVmCLB4yp6kHaU6dZjX6+dGKFuAj7fzVp1rSgRkpE0vU0DnHB/0n5?=
 =?us-ascii?Q?wYHMC00wufRqryjCZdygCt0qcjIblG1qkksNTpt6ilvAHppcuUjas/NsZjmQ?=
 =?us-ascii?Q?SyxkuVoIL35jJhEUpgKcj8uaoJ+okYwwti111QLanQviNWieGyf79iHBme8K?=
 =?us-ascii?Q?i/no/6aszebZVBLiTGTkp3kvCxMgL2rQbU2Gnsb4hgEl/F0XgPg+he1JZqRC?=
 =?us-ascii?Q?o2j+al0sY+V6NOOEvuKv+CbSeaGQ7WxrlmM2PTtxHLYRFlXiN5/T/LLlQBmu?=
 =?us-ascii?Q?iIwZWQXu+ZsyxUm+vUAs+ISxR/HFVF+RKGEGAhgVqtE0XjpNT7GZFHDXpkmn?=
 =?us-ascii?Q?ijb9U165BZ9l3cKK48ivkSuFkfvmantLd7ZX6bKaJKREABQ+UCybL9C61RgF?=
 =?us-ascii?Q?XwymFYJwhU8xMrEpy/iH6qr6KXVWY+0F9gV9Ad4N2cvUSbrlE+zwhlUxYCNL?=
 =?us-ascii?Q?BOiI/Y/t3bk3bW3VacvKhFSCLUfVZi62Ligu3NMywJ9bBbC8QDn7Jvhf1r/x?=
 =?us-ascii?Q?jZi84CydvCYY2HmbePr58XHDIxCgXJDfNGwytdLinRHkqvjzNXPbi9E+yYcp?=
 =?us-ascii?Q?2S/QCZP7mRtZ7R96hBqaHJYqjxQW3Upn5/bzNDZ3Nofkso6g0oWNrKLBUvPO?=
 =?us-ascii?Q?QHvK6FjEpgxSQF3ce4SX6Um/eE6CIxV7wAqrI1O9+sv1vA8Bzbru0j1HZsWD?=
 =?us-ascii?Q?Dlmi/yqU4z5QBZgj7QYxDjvoIAtx+we0pbvvYIitC2FVdD3hSCa+RjiF5ckT?=
 =?us-ascii?Q?/MMj+7yZnjNzh7Kcqpgx2psdSvIPqptRG3nyhFIYDzktkA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qWjeDc+V4TU6soM0bqGanqm50+qaP7XL+ksvXI/vFJkA4fINdq2DiYvxWn30?=
 =?us-ascii?Q?I1A3QYS53Io+INTCdQpATlBRWHZ8SPRt/F4TilhrzXEkqAfryDP9E7uR2NNk?=
 =?us-ascii?Q?JXalEL6ATN9m4eUNYiIlxuG/K4CHPCpRUl7Wy2nbeiOskmEy15enycCAE1u2?=
 =?us-ascii?Q?eweZF+NKBO2kQtHl1q6Ow9KY2GDBBULuLl91XNaL16fTwljR7hVWOPDsb9Rq?=
 =?us-ascii?Q?TmSC3KoDN2mincEE6fMtlsNxzl2buAh02hqp2hmXfcvRFnx5TFOHTUFFYoFO?=
 =?us-ascii?Q?npuAZLK3l0PmqiWg7FpCJ0Wh2GyXqOFFBmUz/i03KxfoAJ/k8Uejj1DYC7jc?=
 =?us-ascii?Q?UrPta3m/fTNdgS5HJ2qFmpBSo6bHCqQdNGguDUs/9bnvrsgB+WdQDadRGMF0?=
 =?us-ascii?Q?sqYMAv0niMK+9NOpLFIVswnqNJRgct+F7VuWwcBRx15IbRoarRoIUef/IGJl?=
 =?us-ascii?Q?Rs8+azD2eEY/RwWtnX4fl7QYMO/q0npxCQdDDbQdFqOddTno/FJSTgbV3qtM?=
 =?us-ascii?Q?tdhubcyD3RrUl7or+NOuWxD4yC7Y5CbfvTHZoFXrZDxLh0le9B8xzy6H//Fe?=
 =?us-ascii?Q?qyl8YmR6hzmzlwTO4efwb35X52BGR5J4WEq25ASAi9NcOmo5yIfOH/NLSdTV?=
 =?us-ascii?Q?xJR4AXub2KXW4P7dwuWB1z5q7SCY+zLgC3qtVRLWMtb7q/wHFxF8WuaJ6c+/?=
 =?us-ascii?Q?IJEIivoLlZUO73IhmsHG5W8iND8PXl2GDbIUItEyzy5BchPQAb2iEPwK6hWN?=
 =?us-ascii?Q?umovZ8YffW7stJvpCqDUavz7yEhXfU8HKVyYVFBVDSC8AcVpcJDyJ39+/0Eu?=
 =?us-ascii?Q?sPZtIqmL9hzzMLryVCH+oE/x+v4gJLRzyP79gVeqD139urQN2c9AWg+/lYHQ?=
 =?us-ascii?Q?CFSojM1iZxZmlteb5mnhDsqr6CdbncqjkFlvOBbvIw4g5teP6guv/B+/nOUG?=
 =?us-ascii?Q?4atR8+2H5zAgtzfpKb0Mwcn4sQcMVjwLyU6Rehrux3pFzj83G1tYLnHROBOu?=
 =?us-ascii?Q?zOZYr+l3GVLEgAiaE79XTJKa1XpW7Vbq/yRQ6n1KItir9U+zA/ywJq96kGop?=
 =?us-ascii?Q?DHCFKtVXka+7yNWNXWso39yX+EOT6xOnLZ12jNi84XaVDsDCYh84bNGaJJor?=
 =?us-ascii?Q?uTrIfHHAl9DGQV6cc4UB+UdbFtXCxifXyS+urW/eavufcYw1Yt3rgoSY6ePX?=
 =?us-ascii?Q?uLcSK35AUgeweqaRKN96WT9NGSLheOD4OFFSyos8ZRa/jZ+GCw7itIbAqw+T?=
 =?us-ascii?Q?jW94Amn1iuNk+8EatQbLh9s+9zvwEn7F43YkJ6kwT9vJQUHZEECd6HjDKkRh?=
 =?us-ascii?Q?xLoTRstUI/V+lcoOUCcB3TodTeZJ4O5hn1VAU+iNpDl9l8e1zZixMThZCy1D?=
 =?us-ascii?Q?W/Cg56LUmcTlZykKtSKXEkRjlZWJcW4ZPMlr5iSUWf83uCuA4WS88OD/e6li?=
 =?us-ascii?Q?i5cF+sOh3hRJ6Bh9mQs8v27lsSXcaAn/lpDWpV6GQeTq6wCvZ5tIa649ZW++?=
 =?us-ascii?Q?gg6JddIzUOWP9kqDbA9M6nc6RnhybCwwRAwNw+P8F8unmnuUfe5nwKkHShkh?=
 =?us-ascii?Q?C3jKLppXLK/fKsmQ5LMID/XsNhZ3GWjaZgF1vY0x?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a8701a-1d3f-480c-d53d-08dcd1201a3a
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 22:38:18.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x7C+y2HDybWELaT4idiVe63ULZyUq5afQ/HMwKNDMNMro8py6ZBFqQYDqd3gzCfqZs1924UlzHZh4Ezor7NRBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6863
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Group all cxl related kernel headers into include/cxl/ directory.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
