Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F6DF1DF258;
	Tue, 15 Jul 2025 17:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752599265; cv=fail; b=anV/ModEUE4jlXGwo0vB9cd0p0lRnVTR1Lo9O80Rcp0LneR6cbKq7JoDJ/Dx6BpaFMY5717WqXh6KrkeTcwvExdufjWegUO8TG16Mlyq/aROuaVY5+fFODLz7VYEWlb8TQNszysD3q/270c7cByqrE7LwLkeF1nMjrgLKFlx4w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752599265; c=relaxed/simple;
	bh=skBFju6zEsvPPvPzYDgjAjxsVdLpGhjZoZFKgfwvds8=;
	h=From:Date:To:CC:Message-ID:In-Reply-To:References:Subject:
	 Content-Type:MIME-Version; b=NO+9o14dFy/QxgG9hYpwyUrQQhtXtjUk5efcg5DxgXgX6yushIY7g5yKp+7TXdckN8xAvS7JdfsJxdl3zEJ4oWdHYSmA3DXV2L9tkpOHH2J9oWGzcPMUnVAlqaYQ51jzQQ7CERJRAqFufsq8Ndx2q/kmKcT5DJ1Q5XPZi6+yMR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nb6gHifp; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nb6gHifp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752599263; x=1784135263;
  h=from:date:to:cc:message-id:in-reply-to:references:
   subject:content-transfer-encoding:mime-version;
  bh=skBFju6zEsvPPvPzYDgjAjxsVdLpGhjZoZFKgfwvds8=;
  b=Nb6gHifp6LgJQhUPXvIOTRcYQX6jin1WX/2Wqe/RJtFiWlxQDY64B1pe
   lv4lFTpRbsBzCYMZhngsjFDYqH63OllKLKcNHpOaRjEVZ9eXcjkJOB5sC
   GFFkfdSiV86NcZreygmL6gUmHg5WqSLNnGt2SjK/7649IEc2PP/o5MarB
   IPnXyC2aiVOmcO1Sb4F+/bquEINlonWj04qxCo+odim2ND/iTwWL9LlKx
   zlcY8PZpx9x4CYZ8+JIPRBl/aoc5mPB1trpImA46Xpi5HW+oi8sqX1BPc
   GdRsEecXPLuz2GJ219coeDYyZwuHxggnaFV3k8RJEUZRMnr1qtruZ+HFP
   Q==;
X-CSE-ConnectionGUID: kGHYVu4kRhyKUc0TCddipA==
X-CSE-MsgGUID: QcTe3aK+T42f2nKLK6zNEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="80273956"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="80273956"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:07:42 -0700
X-CSE-ConnectionGUID: lHQoirmDTMiFJZxJy0cGyw==
X-CSE-MsgGUID: myXiq0D+Q5KLhZw1zJqSJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="158003209"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:07:37 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 10:07:37 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Tue, 15 Jul 2025 10:07:37 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.64)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 15 Jul 2025 10:07:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avQZDOcqgY8J1SuEcbD1sxGAbhu70eigJQ9u69OgWYUH74TBU1Z/ecRAXFnzCaFkVRD3C3TlYb82tmPDiHSSdOMx1hUa6rnlwkrdHeKRtPzG5L+ebAzG742+/RmCp2gt98eRnLd0hbucfPm8FCZBVRTWkqbW36kRkA5vYx7aqUMO/E3wBylpkWo8toR6jZEOa6wWzudrepHVbdL70rRArZ3g4Wt5JU+Jq2LfLiU558++Hd4frFCaIRIcE2vDHw4DEsnaZrK01H4jGB83UwbNpwBpmblsAhY7z4oouJ2xh2OhLTLgQpwgZzlm0ykGTdHPVQTK3+w+XNkK/ov4Ssnvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/fp+/tdJ2+scCTukz4/8JDWq1lVLek3IWu2EA5okJLQ=;
 b=e039DkuYIT/AV2JgEAlq9uyRCedZZH3Wf6MlKeMxfYO7cCDk1zE5ha7/Vk8p2i/7nmIynvpsI9h5/oOCC/OPcDMxqS70Zf4iCXMIsQgiysTqxvhSpiXPDlRi4K5nQSRCsw5swmAZQECZDxK+ipAwLXL00l90qw0tUpEgICi64OwRXYL/higwOxOm0Lm2PLtxY3EFkUe+cxsD4pYpup0VB+c8pFuz9F93AEy35BNK6hZ8Hx1gNxwT/sf9GU6XvMn+jCFcbIG4LGuBOw/ArpTSJHfh9yC7lszASkmSPzXE+rF3IxMlMrMfoc9MCNKO/yGznqYap6CyBIiFqpysn/9bBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA3PR11MB9087.namprd11.prod.outlook.com (2603:10b6:208:57f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Tue, 15 Jul
 2025 17:07:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 17:07:33 +0000
From: <dan.j.williams@intel.com>
Date: Tue, 15 Jul 2025 10:07:31 -0700
To: Dave Jiang <dave.jiang@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>
Message-ID: <68768ad36e84f_2ead1009e@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <bb4507a8-41cf-4e0a-b8ac-ed2aa9122f8c@intel.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
 <20250711234932.671292-8-dan.j.williams@intel.com>
 <bb4507a8-41cf-4e0a-b8ac-ed2aa9122f8c@intel.com>
Subject: Re: [PATCH v3 7/8] cxl/region: Consolidate cxl_decoder_kill_region()
 and cxl_region_detach()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0154.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA3PR11MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: d6870018-e831-4d75-3847-08ddc3c216e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q0dQeldIazJSM21ydFhVMCtsOWIxbTI0RDNIZ1RQWlU2Vk9OY01COGM2N1o2?=
 =?utf-8?B?TDd2NjVGVURKb2MxOExUeWx4YkpTb3JJWGszWTFiY0xOa3l4MFJ3RXBCZ1N4?=
 =?utf-8?B?Y1BObG5qY3hJVTFpanh6b0JqZW5ZeWVhTlgzc0hjanJUVEhEN2FZK3h6MlZs?=
 =?utf-8?B?RTRtZEFCOFdhaXdLYTc2WVl0dkxwblNRZXNmdVRyQjROaENkTVNvS0g0V1Aw?=
 =?utf-8?B?VGpEblRmVWdibFNBMS9Ca0hwU2Y0cDJJN295RHhCeXkxSWZoN25WOXlvMWJN?=
 =?utf-8?B?dzRJR1JhUG5aVHBwVmE2M2ZlRmpaSitLZHhqZDFDOXZGalFZUGtDdXZlbGt0?=
 =?utf-8?B?Tk5CTkZzNzQzQ1l2U0hia1Q5dEMxTjZzUkJOL3RCc0cwVHhtN2UxREsreHpj?=
 =?utf-8?B?VkFOOWFsem05UjA1QnB3ZjV3ZkVEOHJ3VWJBdVAwbE0yZ3lkcGVtdEpTZHB1?=
 =?utf-8?B?aUVBWjEzNWVoL1QwaWt3a0pKUllCc1NaUXQ4ZWdhUjRvOVlJcFFMM0c5L1ZY?=
 =?utf-8?B?UmYrMnJEaDQwcVE5ZXlQNFJ6eWpuamFnQ0VFYUcyZWlUbG81bHR6bjZiNVBU?=
 =?utf-8?B?SnBFNVYxNVpZSno4WXphSUVVRjU5N3lkUzNKUjgzY2ZhaExmVUVDM2ZYazhJ?=
 =?utf-8?B?bXJKbTZPd0VsWU0vWHpTTjkrM0hWTmh2WlhpMG5YQ0hRejlDSTJuTkNHcHho?=
 =?utf-8?B?cVo3ZGsyR2VNaFA5czNJTTloZDJ2eDNzSEwxdThDWkdHRXpxYlZRRVBYeVZ5?=
 =?utf-8?B?REl0bk5NODE0UnA1ekErYWhZMWs3cUEzYTRHTkZpb0p3bXJsbTNWeWxCSFFY?=
 =?utf-8?B?d1d2L3orYXhnSURZYlNud2x5UkJXZHBweC9LZnloUktQTmUxZExVZk5IMTJR?=
 =?utf-8?B?SzhTdlEwbTRxVkVDbDkxVTJCTzBmdlhPMGk0ZHk1dEJRbDcxRVJlQW0zcm9U?=
 =?utf-8?B?T1V4QU95U2JDM1VUb0E5WXRhUTdYanE2THQ1aFYrZHRjcUp5M2s2d2ZZelRt?=
 =?utf-8?B?dkp0Qkw5RVZRTzlwRTlqQ3F1SWJiS2I0TVBRaFpVWlcyaEJTVEphTzFHT2lS?=
 =?utf-8?B?NVp3NzlSUVU5cENpczNtQmxjR0gwZFk3b0xtbDBpa1IzS3dOUUZQUzZHb1lQ?=
 =?utf-8?B?TkdhN1YzQzhSNXFNZm1XNFBhUVJ5TDJRMFRZVi9zeGRKNUVzYlVxY3JEdm1F?=
 =?utf-8?B?dXFUbUdVa1NoUmw5OXBISVBSZ3lsZDNmUzd0SWFIWjIzbENjckFTZGlEWStM?=
 =?utf-8?B?RFkwaitWR1FybFhBZzB2S1krUU5uaFQvN1JQMXB6S0ROR2l3d0xaV09Ma0NI?=
 =?utf-8?B?QTNVWEtJOTdBb0FMblJMTk5EVWpaUTlHZDkrVG1VdEdaRTF4UXRyRXVWTmp5?=
 =?utf-8?B?THFXSVVzaDdhaVNTaWZSYmdHOUVJNU5ZYWx5d1BuTjdMMDNIRHExWjFPRXN2?=
 =?utf-8?B?UWt1NERnWDZQcWZCUzFFME9vdnp6L2VhNDhVeUt3OHB1eFZNM3AxY2Rsd0Rr?=
 =?utf-8?B?dVc1WDZtc1FiaFppRWR6OFhDWWFUNmhoUlNYdXVHMmtRemlrY1ZRUGxiaSs1?=
 =?utf-8?B?Y3pQQjllTFc3R0p6NDlZZWJWMkpUZ0FmKzY0WVc5N21JY2s0MGtzbTh3ZWVw?=
 =?utf-8?B?Uyt4YkI2enQxNFVCRjFiUlRWaVZxblhZRkZNazVYR0VWWCtHc1htdzJoV0ox?=
 =?utf-8?B?cXR4VzBqbDQ2Tmd1OGQxbDhGSEd1ZzlDcTROb2hEeEZlOXVrZ0RRdktudVlz?=
 =?utf-8?B?TVRNY3RCTkFZVURsOHIvN2ZJYnAwMGJ1c0pDcnprUTl6aENJN00wU0VPb2k4?=
 =?utf-8?B?TW8xaGxPRVZEbjc1Vm5HSzVqVS9vR2hKOHluaDhuR2w3K21PTWp1byt4WEsz?=
 =?utf-8?B?a0R0b0J1R2QrdnVySnNjZU5kL1VqNkFUKzAyMGFmQ2RlZnc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG43blhFSm1YUUpnZ1UwOVJQRzNZWGg2YVJTMHA1a3lHNlNMQTI5K1p5MDZJ?=
 =?utf-8?B?M0dlN0V2TlgxSXZYOVVCQm1udzBYaCtPbW0xdC9UNjNXYmUyQUZlWmpFRjgz?=
 =?utf-8?B?SHNCNGtMb3ZsRldmMmtZSVhpa2tlQ25ZcExSc0hvQU0zVkFzZmV5Q2NmZzNF?=
 =?utf-8?B?MXlqejhBa3JIOFhIbityUFFEWUpPOVd4b3JZUzg2emNWMFAyNDRDd2FURTVp?=
 =?utf-8?B?eVZuNTJCU0UySjFMdVMxaXJMZjdSNHdLYi8weWJpTC9QTkYwaDJUSlNLRzlK?=
 =?utf-8?B?RFhoNXJabzV1dzRCQytTY1lNRFJFam1xZCtsWk9YdHdQcFV6amFNSGhGVnR3?=
 =?utf-8?B?c0dhWTlPNmZmOEFIVjRjdGY0aVMzNDFKcVVFOExUTUl5QVJyLzRyY0JCWU1p?=
 =?utf-8?B?dlkrZGNHYnczbVVCZ3JJWjJpc0FkeUtDaTZjSEpGNXRxZE4yYkg1TTVkZjRE?=
 =?utf-8?B?L2F0MjByMXUzQTBCTGk5VCtMejV4K0VVNkxLNHRWWGNyOEg4OG5jMXdZc3FN?=
 =?utf-8?B?YTltakZaci9hVW9MNmVPV216cEVibUxLN0hoYktFM0hvcWZCSUxvMnM4YVBB?=
 =?utf-8?B?dXJMa3ZTdkZLdG50eHRUbUlsYVVacnN6OXFXa0pmbnlTRmE0UVFlRDJJQk5M?=
 =?utf-8?B?MU9tM0hGOHozRXg5MmZGOGFHOWhaVVpTVS9jQVZWWnRTT1RLSFBXZm05S3RC?=
 =?utf-8?B?SlRENUptYmVwVlV5NG1tazg3QzdlWGYzeExZeFMxUU1tRlU0Qy8vR1UwYWFT?=
 =?utf-8?B?LzhRUmpJMHpOS0k1YkJ2QXBwSkhjNWc5Y2pjU3FwMlpXaFJlZS9FN3lFUnpX?=
 =?utf-8?B?MHFlM3RUaEZ6Ty9MMkNvY3EyRXI1NFk2VDl2ajFSdXNKMWlQdnBQeE1za1dC?=
 =?utf-8?B?am04QlNZNVA3alR3VUtma2FaYzJka3RJMjlGaEpWYnBHUmZoaFFpb09BZkhk?=
 =?utf-8?B?VEhZS0hvNzJ5Um5QRk1QRFB0NFpBMGtlSEhzeTZtaGJBQkN4U083VHBZZWtM?=
 =?utf-8?B?b0x3Q3Q5NUtQRGk5Vld2NndJMVIrOUtNc3k4MndpenRWSU1jVUNYUU9PblFI?=
 =?utf-8?B?ZWhyTGUrQXdpSHpCc2dkeFBaNkszNElVdTlhc2FIKyswbmlUS0J5bUJlRmR5?=
 =?utf-8?B?Q0FCWkNjcVZKME1XRmZlcGdYV3NUaE5wMFNMZ2ZvaDdFRjJEY2lla2Y4QUZ6?=
 =?utf-8?B?eXBwMUtaMFBuWEtFK0dRRWN6eFpwWUJ4anQvYkZkbUJzMUJmVHlpckZVbFhi?=
 =?utf-8?B?M0tFSExJdVg0TjBIOEhxODhQdXg1b05PekNTYmtleUFPQndqZ3FvY2FGbE1p?=
 =?utf-8?B?ak1wNWRmc1hBUDM4MVA2SkFsSE5HNnE4b3ZlbXV5eG1CVTVEWmJma25vREpE?=
 =?utf-8?B?VDJ6eGdRaDNleUVlRlJOUHNaQUd4QkFIN2dzWmpJd2pCOTVCYXRNVVMvVFox?=
 =?utf-8?B?V0dpRmIzOTM4WWZoZTRqSDNkV3kydVlKWXJqQWg1cTNTaDBmM2xGdE5Pejhx?=
 =?utf-8?B?cmVpSkpSU283Q3JWZFFtTGNiUTFNVEZFOTdyNWJuRFZ0VHlrUzF4ZGU4dkg2?=
 =?utf-8?B?dW9BZWs4TVhwSVRaNHN1VHZkYS9EUitpaHBPL202T2VoZWdwMVQza2ZoMnRq?=
 =?utf-8?B?NDdXTVVFdkxuT2g5YzM5OE0yQ1FURkQvTTVXVUxjcTFuYmFXelJmalZnVGc4?=
 =?utf-8?B?cnhMZzQ4aTNlMXcvNjl6QzQ3QkN5V3dRMHI0YlRvYWptOVNZNXFQcFlYMXFw?=
 =?utf-8?B?NlZ3Y2dINThxUitVNnhNSFAvbkZqMFJkbmRGSFBCN0YwQS9naFFmTVlXSm1q?=
 =?utf-8?B?Vm80SnA4aTZIeWFnYitsTjlwakd3NUZ0YzNidlpjMDdKeHZXL05wWGxCbFR3?=
 =?utf-8?B?RWhUblREbWU5QWUrZ2RpckVHRFkvOFlGckpBT29LVVJVWHcyUy9HRU1HYjhK?=
 =?utf-8?B?Y3JEbkJIcjZDNTU3TVRrQU9WeFFwT3hKekxDRGY5WjY2WFdTNzdJL0dxNkx3?=
 =?utf-8?B?ZE5zdHc1WVNrTkw5TmNwSzBpVk5zS2VFZ1FNY0ZzV3ZtcFAvOGFvT2FkWjBD?=
 =?utf-8?B?WXd3SDFXVVQ3OUthRSttM3ZvWHY3cVlnT3dnSUd0eENNWms1MWRtd3hERHgv?=
 =?utf-8?B?WVBjWkJpR1ptcGdHUUdneS8vdUZjbnIxUVZrL3JjNWhUSzJ3U0V6ZkdWSDIz?=
 =?utf-8?B?Z1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6870018-e831-4d75-3847-08ddc3c216e9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 17:07:33.3168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmlbOtea37JQ7IwK1qWKXPFy5df3JfL/hjwcKFIMseaugdoKiIXPZlVXy/dS8LLNIh+zTbwFHL0DDrEfuELf7I9oQqugUFCotvVIz/zjNag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9087
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 7/11/25 4:49 PM, Dan Williams wrote:
> > Both detach_target() and cxld_unregister() want to tear down a cxl_region
> > when an endpoint decoder is either detached or destroyed.
> > 
> > When a region is to be destroyed cxl_region_detach() releases
> > cxl_region_rwsem unbinds the cxl_region driver and re-acquires the rwsem.
> > 
> 
> I think this one needs some commas?
> 
> When a region is to be destroyed cxl_region_detach() releases
> cxl_region_rwsem, unbinds the cxl_region driver, and re-acquires the rwsem.

Yes, modulo whether you believe in that last Oxford comma.
