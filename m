Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEDEEB3;
	Tue, 23 Sep 2025 21:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758663645; cv=fail; b=O8WpZN+fXgH8zkAymtxKzHSdqyFpvYkZXGYGIWdrqugFCZQQm/1ACdtwYfZw0e2sjTedhkXxw2aOsfCohe5parE/8i14wYcgx+ZyQ1IYWlOzq+NweFJjfFcdb5z3voZA/3SJWufr3TvSyjbt0RLpWatNO3xrwGM8uZxvZkMTUd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758663645; c=relaxed/simple;
	bh=WfNl5VV6sscH0HTu5umlR97ju/fMtU27FHZqLSfUOpU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sqdoy0Qm+Mn67dHRwPWCM+mey0FLaYu+0dRCpPltfwcRZyUH3ZN0yWecjUdZp8VLO8Wi87oIhf2cPlaAL5NbhLdV7fiQQKRXxpvLgoXWhgq95fivUpMjtwuvLtUSR9JXTUQC+T/RRzRqpygOwh6i1GfNN3olOKjRzX19bAXNL8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y5rsfeB2; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y5rsfeB2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758663643; x=1790199643;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WfNl5VV6sscH0HTu5umlR97ju/fMtU27FHZqLSfUOpU=;
  b=Y5rsfeB2zeUzaMKOAwH8ifu1PEbropeDOAPhLoh0EW6ca52+/JzyvsY1
   GMIdOYaURuokP8B8WIWp3cnv7LaxmL0GYKNiRoIWM8VfOU5KyQqrbCu/s
   uMN/TCBqd2JP4sY8qqLk5OAw0DtOYcWigSZiizzTbb2ux4H2wcPH/4k5P
   zDMu1eDMTparQJnAlXgVoTEEHl09wF26Ghok6UETuBPWn4EBojBv9qvyQ
   acNNfZtP6PLQ662rJw37xGdFPCBrn2eSNgof8emkzV61ua3hGRJ+Y5qMO
   mqhpc5kRWgqzHdb0be65O68Dp+iiI0T0OYeakxrLJaS7bui7Dbwx+pF9d
   g==;
X-CSE-ConnectionGUID: TqZ7oQGhRyqQ2Oyy0vFuwQ==
X-CSE-MsgGUID: ujOn6KPdQQWVVOGhXkUnIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="71626813"
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="71626813"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 14:40:42 -0700
X-CSE-ConnectionGUID: EIX+8IMBQyu5RtwbKjNssw==
X-CSE-MsgGUID: OgjONRFYSgaA3YIkPkZH3A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="207623709"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 14:40:40 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 14:40:40 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Tue, 23 Sep 2025 14:40:40 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.66) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 23 Sep 2025 14:40:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EWeXBl8IdhOosByNCwPB93g93PGbu0bD+8wPf5Zc8s86z9aFYX24wVxeZrTmvYGc0XayLgpNOdIamXMCqNRUKerfg1h24LfVSq96bCMgvKuSIZqH/uUBdFgzM5fReQa2/ZlW0eU0lpAtjx1+QJ3PjeLG6E5YidXuCYVLyds7YMHzf2p5EMD5Py+h/zBbakbML3UDEmPYWaEr+qktSaTsqHb3BQVph2hN43OsbHbyM1A1pn123Rf5LsgeVaItYJR33/tVeNPltihCFKuCr+qLIG6qGmFpHszGaqvyY3SWDrL8E7lkrVVNtMpY6zCQxlk9jW9tgid8b4+T+6mcuaMWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQmR1rQCLjccASTVbmDLyPDFkjvd5MI+d11LC3ilVjM=;
 b=XmCGRpgZpmgJ3rVEJYk5mYrW1LgOT5FTK8wC8LYmO6g7tbBI8urcXHoUoX7fjWtgwQeWhMEQCn0HfZ0aZktgoeCB1VMsd3tjcmw+KnVReFFhtyJLnUERyY90ypqfWy0xVVDsnXtqKtEslrc53cXuirTtvH/7xsIR9auy3nhb2gYlmdvyQ3xyjDHKFdKkxyl8GYb4v7//py98RcCJol0XZSp8jWXDI2I5W9DxcoXQreIt3ABKlrLxBrGfUw6Pj+tIAOdS30bOva5nq/xwIAQQtMRf0eA8g7KbJdPPGOwlWjfl8nPTmK84+iGh+qOJ1DrIJoEn57N41/58nKAIr/AK3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b) by MN0PR11MB6229.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 21:40:38 +0000
Received: from SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::4df9:6ae0:ba12:2dde]) by SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 ([fe80::4df9:6ae0:ba12:2dde%8]) with mapi id 15.20.9137.012; Tue, 23 Sep 2025
 21:40:38 +0000
Date: Tue, 23 Sep 2025 14:40:31 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v3 01/11] cxl/region: Store root decoder in struct
 cxl_region
Message-ID: <aNMTz5d55LqXDiek@aschofie-mobl2.lan>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-2-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250912144514.526441-2-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::13) To SJ5PPF0D43D62C4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::80b)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PPF0D43D62C4:EE_|MN0PR11MB6229:EE_
X-MS-Office365-Filtering-Correlation-Id: 03dd0e66-0eec-4493-a3f5-08ddfae9d5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L5UnTBxWRz0ZqCUjq897DDwUJzTOp1x5ApXvoLu9oyd/njAcRGwLn8H9q9oS?=
 =?us-ascii?Q?bdt2aEUXH/cmu57ShQRvW2hX7zr8ZbSwWb75gMprlRMbhIVGaw4QLszdMfNT?=
 =?us-ascii?Q?uORGFvbT8pu1v69xOBvYGCAoqOb1KOLu47k18Pgn0ILbabNtdS+bVreamsqr?=
 =?us-ascii?Q?c6KX1t454PsVpQEo/N6QJheTpRxF2fijux9WkOVi/K3zqxHCT45OR4UogO6k?=
 =?us-ascii?Q?hBRh1R4Mtk+HQsSDwrnaSY57C78OIkB46lKpDA4tgtwcn5xF+q0YC5Ejy8eE?=
 =?us-ascii?Q?0NYibcVpB1ZZC2YzBhfTiRVzh5VT2N28GO0dhFUI/1JiQA/Gqg0FY2y6xggK?=
 =?us-ascii?Q?HoIBxnCe6h4AJG8MWXPhfCbnpnBoNCMmPe+7izvuqiPOzZ4kqgOmStOsLigv?=
 =?us-ascii?Q?gPFZJYm2g7hDD6gz+xH8D/hIkKftgCVEpJ3arndURPX3XmTUbZVJQqPdWdre?=
 =?us-ascii?Q?78ujDGWOZJy9LGwy4Ub/b6AuBr1hJi3Sv9ZcE33JpJ3ycROz4VVZb40Co5gd?=
 =?us-ascii?Q?1LZo5zfjX73+CjrjOJO+7A/h4/9GXQqBQEK7TTPV7YSpxwOJxVhAcxWMAnay?=
 =?us-ascii?Q?MvQRVgFrzWkfXUh6jKKfNbz0R5XNxJq0RGPp1b0fvPW6Pnj8r0/oC8AcYxYL?=
 =?us-ascii?Q?yjP14igLznELLhq53y66hwqgXG0Rbb2PsQ5JT7eMY2FT2EQ7+BIKiziJL1EY?=
 =?us-ascii?Q?Q8j/0UKl5qvFqPn4gAr9EnX2MRIxBmFg1p6kT12w7lYfWbEyLvKCFbWJpbRO?=
 =?us-ascii?Q?KMz6EHQ/CyQ2+4JgKDVJB5H8mzhrskrlPweSllIoZKF+Rq8jcOVPt+fLmDm/?=
 =?us-ascii?Q?00yqlQZrynGqot7MsqvXqJcC4RFpUfGTj2G65Tx+FirPjGWWEVi/ICOUfu+B?=
 =?us-ascii?Q?OLEWhPBSzvfpVN+1KyeZKp5w7t6UEtu++Yj5YXiGchMkFcVwPxvbYIS+sFj2?=
 =?us-ascii?Q?bU07brrdrWh2pW4MyGKxKIZb3ntzeo6ovavAZTS2KnPo28eZDln40r1NhQYA?=
 =?us-ascii?Q?2sEIuxcdAoc4LEhT4MpPj1fl4q+Ypsx24cmn8l1N3BCEtlj3tzEWNMvWAFdk?=
 =?us-ascii?Q?kfr3j2TxZOhaUXYLz5ec21CMItYUuHst+QzszGuuKzoG2oavPIFS8wYJjSVu?=
 =?us-ascii?Q?zq/bdPU2v+T4x3MJn4DU8+GXFvtCqfmhM/hQ2/pCllQyXLj3mbezxbXdU0Zc?=
 =?us-ascii?Q?8lQgdJcpO0YQSDNn84ESaub4QByZvuug9oyVvaxwsQOvxzG54jumNcMxVuGX?=
 =?us-ascii?Q?vwAM2QqdTXQcb1pW7sBbbZLXNgS1jbeip+/Eqhl07l7/ScaDL3knLyBZFAmX?=
 =?us-ascii?Q?PKdi1kQPdiqnkKcOIzMRXSCFrFMD7/PUZzYAOsK/SDkuC93VqJ+rXOcrS+mc?=
 =?us-ascii?Q?LeUlCfBqSM7FliRuQgalDaGTjpQYtGhpfpa6irXjqYLzUhycWg8+Ks4A7XZ9?=
 =?us-ascii?Q?5beB31Kd1NM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ5PPF0D43D62C4.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?50O07wfcaxt73iI5WHqkV8/MZ9m2xsrdqaH4uX7c0MJHXTaP9mk8EO6OVj4h?=
 =?us-ascii?Q?a3kkJPK2OyvSKcPlyOHyd6ufs5finvRZ2BOpNgoia2k3dbv0d1srJVXyttdn?=
 =?us-ascii?Q?HXWIjW4A+ki4ACgxWX2xzUfIFPQqL9UVmOYAauJRzKTRzJumV+mENGcFFedp?=
 =?us-ascii?Q?nQuvm655sGcAmB3sBLxCzqPPuaOF9+7gqhR2TV9DOlD/jAnMIGGbEd4RUuHx?=
 =?us-ascii?Q?77R+NpZga+bu/KpN6FIwWZ8AYUW4cF43gH5YXbmNmdR9smwzKWlKcoS2gVNH?=
 =?us-ascii?Q?euHo/eD0cnaQyCx6PoyqUp7anYVfqXjjRAFWq5r9bM2LKPk4vtkMNU8uMSRo?=
 =?us-ascii?Q?7ULP60Ehzdjv6MI8gDXN4Y1lIuxbW5xSW5PyHEVT0pgad9Q/2tBez7RL13Ri?=
 =?us-ascii?Q?dOcII988ELGTUFm8gP70UjcNh7jMCOmxAxkA3NF0uBweIbrrdUcZTR2BIINS?=
 =?us-ascii?Q?dvrQeRqTW89fIXJupJAyY0mNf6kueMKamucXv8fRi6GLk6bsQyoOAGd4Mqk1?=
 =?us-ascii?Q?Ne9M+iiU3YaPK2t3frXR4CxCGUdb1NKzCoIjoDfD4NxBZMc/hW4tu83wsoyp?=
 =?us-ascii?Q?JEkf1VI/2vj53YYpZhthB/Eyosi7RtrRzBsC8fm3gyPxPLQhTfBf2LXmVGhJ?=
 =?us-ascii?Q?HRUrFaMUPP3C6mVtALU7I/JMwwHQyYDdTqnOWrLJEpAWmRIaBa5XczGi/dFu?=
 =?us-ascii?Q?CEPL6OoLrqLmP2klJ5n1kGGFyyULBuvI2tNUV2mtu4ICHuJoSVO6/GrL2khS?=
 =?us-ascii?Q?6TRBiPbjTWv+1osnZc9i18uuVM0ygK5ZdsI1RXZxUKRjCZTSrljNCicYCG9v?=
 =?us-ascii?Q?vFOzOvcQAoNWCMA/Bib/lTxxEXElrT62Zs/s84r+mUYtqB5xU/4L5tQhLoyX?=
 =?us-ascii?Q?qIWdsVE7VblGYpLl0ZvQBB+H2+n4+1hFr8QzOEHOBOq4VdX5rDEVLXufjV+Y?=
 =?us-ascii?Q?PGegpBJ5+mXpBY+ClkL/m8TaXgC7/3Ugq3SGm8HGdFgXBsEvh/xPevSS1zYx?=
 =?us-ascii?Q?NIVHh/kEyXPtazHUFk9N0HJjQPBZGcRpb6GpnrZZu2wWShvq9MVDCuUIg6oF?=
 =?us-ascii?Q?1/AKGgh6J0fdliSYcy9v17pk7GEnZAjW9yGFWua0SEf8OtHHyazv5WXL20sn?=
 =?us-ascii?Q?V+ec1yxUGX+q8JZH0X1k9186oGSQxyAurlKRy5TSdKD8XLUUzHzphh2By3mk?=
 =?us-ascii?Q?EYsT2ho+VPKCdX1FjG+S9WiS08BPIXhW8sPWeqqwe8iR3DUHHTjCy7qpIAP9?=
 =?us-ascii?Q?CqXtf29uw61tcayhp48AYY7ZOunCgY84BHYdrMHnZF9AWu1G74ngHDQVPnE0?=
 =?us-ascii?Q?H+6MNLLh1UuGVxxXHJHxd4RrhP55GK89ydv4BZYYXhI5JGUSFkZJEjTZEmb7?=
 =?us-ascii?Q?sgIo476p2kBBpNO1mhgNpofQ8BjA//eJODvtECZFrNTraiD7f+nQfSlwGDVA?=
 =?us-ascii?Q?douG+AfnL1BFkUzkflj2YV7cKY4qpEh5CA4LpLf6b34i8OMyj2ymQCAtpieL?=
 =?us-ascii?Q?dC6lhXceAExPswrbLvKups2tVEV1mPfGvCCgfhmx65PsCHpHAr1yikBHDXPw?=
 =?us-ascii?Q?iiEzdKH9xh/A651GdnoumOcnGdNZaEL+20WaQPgppA4Zr3S1kI5Ee3prRP7q?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03dd0e66-0eec-4493-a3f5-08ddfae9d5e1
X-MS-Exchange-CrossTenant-AuthSource: SJ5PPF0D43D62C4.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 21:40:38.2482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tprhpIq6N9auMqqFUsLBeqcP+TozBhmolqQ9B/2VX84JxcjkQu9d3Q+kq6bvwo4RA2CUcv9LL97A9L92/kjiALWfxXjImm/82ClE8iH+n8U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6229
X-OriginatorOrg: intel.com

On Fri, Sep 12, 2025 at 04:45:03PM +0200, Robert Richter wrote:
> A region is always bound to a root decoder. The region's associated
> root decoder is often needed. Add it to struct cxl_region.
> 
> This simplifies code by removing dynamic lookups and removing the root
> decoder argument from the function argument list where possible.
> 
> Patch is a prerequisite to implement address translation which uses
> struct cxl_region to store all relevant region and interleaving
> parameters.

Where is the follow on patch that makes this a prerequisite?
