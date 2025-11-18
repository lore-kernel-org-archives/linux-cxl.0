Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44F931065B
	for <linux-cxl@vger.kernel.org>; Tue, 18 Nov 2025 22:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763504777; cv=fail; b=qjgj65xUV4JkY/sXwwvjKTRx0RvOBtN6kUDY7bkhMAUeg04tefhGs4LSrICJLCPYQtEMh8Ks65P2h+11OtVjloRwROq17ncgoONXd1sp1wvRAijRSfSrWgGba2X5LHxaDlbg9/F1I0/SH5o08gpI7TZxYEW8CrAG665PFAC57xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763504777; c=relaxed/simple;
	bh=jomYEAI7g8VoEqGmcHJODwd8HoURH25AtsWVJ+H6Lqk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YNyq1zIPu7RQHHRhp4WAR8iqufoa1ZM/4mLeN4tgr2PS+4dorCIq1tBQBU4z5XFIh4bDHrZqz55SWIMcMV/VuNaUsajfEll/wTtyfe81DCm42YSVyYxDTECXP7Pfsn5dICBdNOWsaOafAmsrk6RKaKlrI8oPl1A90VSks1OPJHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hfJuaSvl; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hfJuaSvl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763504774; x=1795040774;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jomYEAI7g8VoEqGmcHJODwd8HoURH25AtsWVJ+H6Lqk=;
  b=hfJuaSvly7s6nH0IsE17sjVcG1tBvYRIP4BbFuenZGYqr09Llh2u4WfX
   pRPMcF6YU3L2ZH0eim8sLCTxMIZjbPWXsBJlw6HFgKMKQiNk3sKXjcREU
   QHX+3tTtxGbcNjFagqUt7Hc6EuoH1XRj8OwIZj1E8dX/jKYN3HRNCMkRe
   AtdnCjdoo5/ZDqH9kYChbjxAcO1/ujGsCXiGfXUX9hsbgtzNn5Ua3shkv
   NDL1OCGWBoZI3sgahfKQP3zYaftIShyLy5/zszhmJFcrC88B9YM958j/I
   DbJyjNzhzZZ/nf6l5cD6fyOcXp3JtyPli/aSY1BUEzmRZkLEhb3OlWaor
   g==;
X-CSE-ConnectionGUID: +BbQ6iaFR+uEr6/fK+WGtQ==
X-CSE-MsgGUID: 4mgry6H+S9acEWWYtJTeZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="83167976"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="83167976"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 14:26:14 -0800
X-CSE-ConnectionGUID: oMkElnzVT9e/Vld82eLMxg==
X-CSE-MsgGUID: 8xu/NuBNRtOTomIOu5W+ag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="195809182"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 14:26:14 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 14:26:13 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Tue, 18 Nov 2025 14:26:13 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.16) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Tue, 18 Nov 2025 14:26:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q02Gc18nh08iuIa4YFTnUp38Smk0/WpG9Ludxc8uxdfjDLt38aICTvhGrCwCrD5IGgMxqGHp25buexKDWs+Q1Nsv3Rs/jrj0ruwXb2v8Et1rYGOFNctbjqDbEsf61UnUXOHTGeNeEZTYGkKiLVFbgQCpQUpgiQCPFuz7aH0k09yoNx6CSGAJJpf91OC7lEy4NlT4FWFCiudlyb2lWtqs6Cfl+NZcY4eERl3YFFq7zVVnOzFTP/Smx3/6sFFA15fUgRZ4UDP4JLqoRXOXxjJWXSbwjSxiwH8W8hQI9KHlaWGCZrV6hQAN7gNe9JmAmNBEpbI9SzU+V/fWLjMFKzDYSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XEnlGJ3u7lAlhnGYMbNPcTr3JWpBwI0FiX91yqfDxm4=;
 b=x2s/kFb0TOIoyDip/pOZ9HrR/JYddhtA8hqpn5w5ZhsaLenEWmUq7Bnaed5GneeSwY5pU75bEP7D5bnovBSW6TR9NlBuAgfOMDiCx9xFnecDMHo80uHhspY88+jd/yznD/9m76d4hQOt71dO1f1jQUWi5pwq2smrc1w5a/YgOg1N2JyWzXZhsRsmfvwC5U5eFjcUjD0LyI/XvSunj9vh7ViCmlaR76WtjLbOTrBRKcfN+rz0IyXQHfVsmSrTTAQEKP9tjXx7CKQNDfrV9IzGN1ZkxEkaiZgn6w/Q+nxJuPFYFAIhgNfy39EuY/brTGl9sY3fmnITHsN0B7D3X/PKzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c) by SJ0PR11MB5151.namprd11.prod.outlook.com
 (2603:10b6:a03:2ac::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 22:26:06 +0000
Received: from PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c]) by PH3PPF9E162731D.namprd11.prod.outlook.com
 ([fe80::8289:cecc:ea5b:f0c%8]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 22:26:06 +0000
Date: Tue, 18 Nov 2025 16:28:32 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH] cxl/test: remove unused function
Message-ID: <691cf310b5fb5_393b9100f7@iweiny-mobl.notmuch>
References: <20251118182202.2083244-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251118182202.2083244-1-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR13CA0163.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::18) To PH3PPF9E162731D.namprd11.prod.outlook.com
 (2603:10b6:518:1::d3c)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH3PPF9E162731D:EE_|SJ0PR11MB5151:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e49ed81-5207-44eb-05ef-08de26f176a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?93A4LalIzgcHLLZmDID8GR9+ekZdHqiq1RPHkZpjVKesIMQnP8kRrVEFjrpe?=
 =?us-ascii?Q?2MGnQ9hfNP0Kc5lGfVPmwu5GUmp9tpN4VQ6Y0+W+P+AKr1mZaMewi++B2b1C?=
 =?us-ascii?Q?2IRyNZF4RkFTLaLvKkhI0LMj8fQzcbtDIVUN8ZnyvSHFSRazf54ZmITcwl1N?=
 =?us-ascii?Q?+7L1yZcgqdFZaOeobhs5sGklK5iKmFDt2+yf7c28XoNPrvfXegaCKXnDrvRm?=
 =?us-ascii?Q?dkIChij1EOyKn/S/OhAzk0B6VpmNYyUVZJlEyHKrBkUjzykZKHsEIISQFMuS?=
 =?us-ascii?Q?DQuJuSMvfL/yQYeI9PEZOyo3jJG2anVnrmwL/OBf040GVPQc7NLMwG8VPn3X?=
 =?us-ascii?Q?kgfps7GQPKmtb+NkFIRkN7jgPldmbz7JgV4JdluLFeBl4peSHYH3/5g8Qm8c?=
 =?us-ascii?Q?eyPa3J/68+aPbpBwE0q7lzxI40iO+VIUD6icTdsb+cxKLKpb9Hv1GZRLTXD/?=
 =?us-ascii?Q?nKeUQQyJYxCD0RcwK9hmrge2aKxttVbyDtZnJ85JMAv6Nybwz529ji8RwXml?=
 =?us-ascii?Q?7BqQP6FhR3mTmTEBeiNK/aZc2utvTHesHANIWOiqG70glVaSk98Y5f/N0xyK?=
 =?us-ascii?Q?O1GA8/7kFoV5e7i28MJ2z+J1LpDUvzhSIu6w4e0c7hmm4VOHqZ4x+5snhaM1?=
 =?us-ascii?Q?ls/xZ3OYr9aUm6XpC4Lq0ofuF1a5CzvnveSke9jCWkXxm361pkcye/KuU+fZ?=
 =?us-ascii?Q?Q6zeH6mLpeZGq9z86kmHw43aUMm4t0vzFbdISSMQYRBTBT7m3y8MqqS8Kd/3?=
 =?us-ascii?Q?PfEVK8M6bm2PpaQet8p9aBCv5BespdE0UBJ30l8QTKXBLr7CEp3/URV4lw6C?=
 =?us-ascii?Q?cbLgJoYRhaEtauruSLp+CVr1LDBcuZx54KZVAnp1ZWGVPEg1rRbR7CenBbhu?=
 =?us-ascii?Q?yD2E69ci4jr55x3AZgcRQDcWkJEm+BjeThFujCPRtAVSdqJa2xaet9mHfyYd?=
 =?us-ascii?Q?VYN2khDZAFqe7zYPiteiJ1ypInfxpRaqywMm1abSMHrSKZ3BK1y1JoyHtI/5?=
 =?us-ascii?Q?PBAhJsu7EwqdLJETpXXXaCEEMWmyrQXRF5KhK7PX3XfELcBK8cM8tR0caY2v?=
 =?us-ascii?Q?WRJc4jS5YHs5av/Q2YprcJh0QFiAh1tv5MbhZfzdqswnHoUH0vh7dvhJBMTK?=
 =?us-ascii?Q?AWN+UGLtq7xY0Hkey+u7usOwODJAViYPshNZ/TiBQxDZbOQ8vmGBEQTMhIQi?=
 =?us-ascii?Q?czb9fYOKs9SA6gbx066S4HaHX9dC94U4NjFfZu0f/Z89XTh3R+nIpAJX5Uja?=
 =?us-ascii?Q?7gO5BeMfvlpliiB1PpDkM53f2vK5uUWU2E+wIP3XUegd4T1reDs+iEh1OQTG?=
 =?us-ascii?Q?Mp+XRwimVu6Ng84iCEqmBr8btO/JMTwvuLtUZTn3Hv8TunCCy0DPbrZS19uZ?=
 =?us-ascii?Q?+Guu1p2AwUd0CBLK+joz9Yy+IYQbsUcA3xfN05UN+oHsS0hQBZhyhGIi/yOV?=
 =?us-ascii?Q?jyujFjQFmIMKHMFYDkYLDjnmPPMUhcEM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH3PPF9E162731D.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VDvDA8b7ynzqzX61/DwLFv1pO+/KwRg4gJE8FLL3dtNeB1AL3tdZfY04YgU2?=
 =?us-ascii?Q?Ct7+G3dmsg9keU0Vul601Mqpn4bI+cSJlub3oyHSRlba31fc0Zgn0TwaAIFg?=
 =?us-ascii?Q?apF8k/m7TmgusK2JLayX/bNV5m6qyfsrTCJGrlQZ/2pSqF7WnuPNM5ZnWKME?=
 =?us-ascii?Q?W7wq5OJ4okajJjYnQtNutFRjIznfLUl1qfxa7hsSUv6gPMfqxKkgKiraW7T6?=
 =?us-ascii?Q?c77sryxtJi0yUUlWUTaTGEmT+6rHG2tKxGP0eLIlcBzGj8jJrBogBUQg+Pmz?=
 =?us-ascii?Q?sC637ZOtvhx3qrfDSTU6TwdRT81fDhCnrBSBOFTVInevb0vhB2EeTd1uR0TT?=
 =?us-ascii?Q?9K0uz49Y3aRhu6QftU8EXgQMk0LWbVgc2n5/JaJ4kc6WOuqkfnXyfYPt4Vzw?=
 =?us-ascii?Q?WEBqLCEmUx2QeqQUJb9TV7oyrj14QXCtvcYhF8bHxPc2naIkzv69l7GxMQOy?=
 =?us-ascii?Q?2Y8iTK9LD1F6jispg4sj+NR8aUUVooqsyfYOUnyROzDJCtm2SyRNbWGvM7Wr?=
 =?us-ascii?Q?ot1q1MYdfsagxmfzlMfFIv09eN2SoZGp8LTG06vr3ZhBQBDDZ6yD2muuYPn3?=
 =?us-ascii?Q?eq7/0LNyF4lsi4eD2sTImDiLcTwWZdzFB+Enqo+/NCVYz+6A7/OijtwaV22l?=
 =?us-ascii?Q?tg6YKpAQd628vPMhw4e+v0PqiwKODxa2huXs1ts65nNMJlmD2ZOnVIpl16x/?=
 =?us-ascii?Q?nYkpE5EC0/eXm2Wu38P+fOdvr5Ir7pBLyPaS/OqizCFHLkjrIWre7sLb5vts?=
 =?us-ascii?Q?Zx1R5KuZFbfY9nlJsyxjVQzBYyjMwAiHrlL7etpQicvkwylEYfkfcDKo9bCP?=
 =?us-ascii?Q?FPzGnCgRQHepS7U733EcNHHmJf5xrusGRiRRGMBhC4bC6TXKp/ymX06t6/lL?=
 =?us-ascii?Q?27uuoyC4qL3ZBWeq7Txc0eruBkKQplqML7nShbTIyzvhIK6XbiQaZntw2cTw?=
 =?us-ascii?Q?c/+LlTOs8owyQxs8t2ygpcL+PeWVK5mQnFGT0MTY+uTOmW5+6RrN6sryEIbc?=
 =?us-ascii?Q?dvgJekaPusRIiwpvW435ebtU+JWoI+sfEVEZYUIyUVadvkq1ouIydvwzvezt?=
 =?us-ascii?Q?WpSN4kl88ZJ1vfyataRVY/sMHOjyrpZkZAxuGo+SJHmY/T3z1hWUq7Sc1Uxe?=
 =?us-ascii?Q?AZnanHdOmKDhEuiI/pz2v9YTr5TUGfNy05/Q+y9nXwvPr+R7tVGL775Q5/R4?=
 =?us-ascii?Q?sEjsxdxnz7AD7sXfBZT9XOexpWS93jdSuUNc8UgRzuxRH4Fv9XzXeFPrRwYe?=
 =?us-ascii?Q?IvfjIICSRyJFrq7m1mKBNs7QadQxo1hkfZpqeSFxXOTU8cSulhqhBD3AK1LP?=
 =?us-ascii?Q?u1KMHOgnl5Z7LzLscudqy6YmtHZ+PrYdZ/O6ZGg/EdT2EyXI9VhyBU58cPJR?=
 =?us-ascii?Q?YwdD2IYyJ3DtNUea+GF+5i66Q4XpVHqHS+M4h0Ed3DDRGxn1yT+4tBu+6C8w?=
 =?us-ascii?Q?IjTQQvy1JBI23MgGrnodnDG7arWZSXi/NqIUi09OHSHZXfIZTmLZ2CUcJXQ0?=
 =?us-ascii?Q?Op/Q4S/gutV3ZqUPNRahr3fdhtCmYul7FXX1uhZqqyz8eLX3lqL7KE9RnUdg?=
 =?us-ascii?Q?j+lLBE2qu9m5W5QaT4jghEbn7Jw9RmrH+3mZPIVb?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e49ed81-5207-44eb-05ef-08de26f176a3
X-MS-Exchange-CrossTenant-AuthSource: PH3PPF9E162731D.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 22:26:06.2597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ayd76gyCkPHJfbdfQ8PIByZ3dl53SMnR5W5F33MwmlmB+XcwUpAKNSYHNuuhxJbyYWKy2zYZAahHYLvXPtGRFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5151
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Since commit 733b57f262b0 __wrap_cxl_rcd_component_reg_phys()
> is not necessary under mocking tests.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
