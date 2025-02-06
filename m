Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C7022758B;
	Thu,  6 Feb 2025 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839825; cv=fail; b=CXyx/Xt41bzj8fxszfSqirggY/kCoWcyEeAdKYF7bIhk8ZWqJ9wDVbgRnMnPxidzjvr2480cGX/filubnxgdkzJ4uRqp5YoyPkK9n3nGFyJoqAOgWCYSpw4h87C1yQU2zKFjOrTVoQ4ud+DGrA1m0B2w0p46E0aS8CZo530qZRQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839825; c=relaxed/simple;
	bh=WHjcCwUNpxB9V4zvs1614Da7LstWz+CjPBUV1MOXf7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kLm+uYf4huHbjddUshazmoK/gnAwvcEU/HDqDoxwwvY/TkMGs6MBok6w2mXDwsP2tx3Jm0Dp91F6otpvoWv/1qPtgm0CL7CPZXB1tUbnrlWSja7/st9eNH1pOy//eXHHbj7zLe/EO07I2fMHOsv6/PT0v5XT6aTtroc32whcn2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pjYNB61I; arc=fail smtp.client-ip=40.107.236.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pjYNB61I"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljG7pFoFGNfZDlQtu+47NQpfBhMmJDdyL2proKDWRomZQvbynmULcFfY4+WWYq5NJF8hqao6KdsEI2HuF3dtRK4bvz++C4LxytuMTo6pc7iIf7ChoKlx7vqL2ZNe2K51x4PWRzN/o3aEfVc20AcvbeTIm6N/OCnRib9wWItUY4TUsur7TiS3pdSgJl1HYq+PVFgG+dLzXryLSRjPzoY/BCmseCRWl/LWPgzZvjKX19uoTppD7ArIjyWRbEKEFSy5ZfYtEH6+pvW+scJmKnAgYM8e+a5XHhJd5RNMA9kKTmqcqyyqseGL0hWb6STAHP+ZeDcIXX0/IrR/hDVG2iuyRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e1nSgAPmpVUHE8XEd3SlQ3UgzSYLwaEW4Th96qksV+8=;
 b=WjaPlZrI6TQ953DdtlIUP5mgk3NmRXSjK+iTcCuU0cwyBWAysdFUv7OKEsQw3kle3sM7ODBNXS8KmeHjNOdEgMljbAtmror4pDY1FP8gXGCAikznA/fF1aYrh9Dbi9zLK14xMZ4BgCFtiNjVqecQnLAHpoqLBHCaano/lWmsBORKEaBLYnzOEPunvj66Yt/iEyBlP29dFxgTXNNBFmxlg9IIm4b0dmMKFtvdntMjTpjdNIdTJs5lL5l3kXNFJ1hCmLV6kFLYyMjHrOBvJlwLoEXE5OI/Ki5585KE4QDKnb/ng7VveW1kTdVsh5r2+IrnufJBoRLSfthPK2N8HLjnfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e1nSgAPmpVUHE8XEd3SlQ3UgzSYLwaEW4Th96qksV+8=;
 b=pjYNB61IGRSTaVjxiWGjtCNhAhdfM6Y6SC12wNjUw72ZFI0as/iqnnbyHHX9KZ/CT7CmqSaYkM2ecer5+YcdicyLuvu5O/apiQeAjTD+KpSflvLr4oQiFFAr7rQGV24CMbsIVTLaTkBHRcjWGn+Jc27rGjIO2EEwq1G36Yl8u6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 11:03:40 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 11:03:40 +0000
Date: Thu, 6 Feb 2025 12:03:33 +0100
From: Robert Richter <rrichter@amd.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v1 19/29] cxl/region: Use endpoint's HPA range to find
 the port's decoder
Message-ID: <Z6SXBX019LQvyMh6@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-20-rrichter@amd.com>
 <b8aee5a6-6209-4091-962a-dc27253e918a@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8aee5a6-6209-4091-962a-dc27253e918a@amd.com>
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: debf8d74-6d05-48ea-e6f0-08dd469de9b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uZSuD9pi5BjHgPdSzwm4OCFlcQpCstBxQYWKbLacd2O/Pih0sPZE7neoj1x7?=
 =?us-ascii?Q?QlXpm2kwkvIUY9hr5wHNeY0c+v2wpamufDX7xIkF+JyXUN6s+qSqeoXgmATW?=
 =?us-ascii?Q?FyDHRDpaECM/1IQyy0VTYgt7Vd1trgnODURWC0m1nwZPiKKL8b/O1Fc7+80/?=
 =?us-ascii?Q?5j/5InNCRhNef8nI2go6iif8IlOfBDhNklqIl8vWP7fbumuvF9SW2EjuTBRR?=
 =?us-ascii?Q?Wm+XJiswxs9tVE4GoUjelF3xUKs2UQ13mKzfWnQ9QtCLKCrWwtjY9h9ZUmiu?=
 =?us-ascii?Q?+z8WY80EkrSvl7u6yjTD3DsBZg/HymsIxYzEuHnGrQ+hq6qDY4OjJZAp5t5Z?=
 =?us-ascii?Q?wE4MZhHCBeumqFTqmBthCEq+LT+X8aYMaHp4j7iVelMQAwk7ys039t+A95EY?=
 =?us-ascii?Q?Yps5vOhdUwOYV425dRwB8t8oHJOLy+9NTJ4x27N+Hn6vCMOJx2cIquKsXYZu?=
 =?us-ascii?Q?XkfN/h48VQ9G2e+tuA/tjM1/w4L5uSIZU9m4Bk1lvSBpF9EiTxLUX4awFoLG?=
 =?us-ascii?Q?tutTszIP/V38PNOcv5vQEVKaZR9W8FPkRrUlBW736Fcgi4JtV9CSXICfz4km?=
 =?us-ascii?Q?ATA+VEbaEAl97baStd0QuyoT+C2W1xDN9pu5AU9N/1Lt+vGFS1Lo2/V4j5h3?=
 =?us-ascii?Q?408tWayUXP/o6M9HQMUVD32m9wS38CFOE8BY0eSrAL0vZgrV0VrvmsVDe4lw?=
 =?us-ascii?Q?SkwtcrowxV0Rgw8poTnFA4JugkKbonJ/MmxhQnjGv2XuzHSWjsHf7BUgxuOe?=
 =?us-ascii?Q?jG+Ahomk6sAT8bBG7f/rENwbex5el7l5y8v61Oqb+X1I+a72V/kPU3olssZw?=
 =?us-ascii?Q?KbhQeIHx9SWpTK2urMPFrGFC1HwnUXsfaNvYhgTyzYLdBCWGtvD6IDTJVZbw?=
 =?us-ascii?Q?jr7C0ky4hfzUHwbfKx3o/+zq8xqcFgBBu+kZQL3TtO3GLghomZ4Alb2pr6Bu?=
 =?us-ascii?Q?/ZumJJkDmYg4jDSFSKkX5De3RTIJhGx05vMVWslmMe4lDZaocIIEblO9uivD?=
 =?us-ascii?Q?cYURFvx5JQvL41MrtCXGWKu4zYYb3Glj5L/YIqMWi84FQXcrRJgYkBVLYaHA?=
 =?us-ascii?Q?WVPa4Jy15mnR2Dvat4Txpzqjtj5zmaFQbHzdXYNCLFkGES2yhp+nlv8MRows?=
 =?us-ascii?Q?Dl94ElnPO76vkCoxtFC0aykvGcOrhWv+qOO/RCoZGyQM32vbjg5SyeSZJhVd?=
 =?us-ascii?Q?svgBNf1cjpG4qUWAZ7D9KbfkR8sDkRqwgIwJJzHgFX1pDFLkWQuCFWs6trCK?=
 =?us-ascii?Q?jURb/zre5Jz9XOkOCCd+NRsW5+7nXZAiTNGv2JQuHCOIH9/vP/QlDsYJ61ex?=
 =?us-ascii?Q?w8W0NwmaQuwSy6jGyYATFOOzRgNNWuNEiHYD2/ngRJNbxSibPknW+EFxpt4O?=
 =?us-ascii?Q?a0uSMcggXXX4QwFvCSCixANxt5hw?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sa5LJ98J6Gjvg/oPLsM0FDZrlITYv04GxI+gt9ltZmz+fSYBVGeLDOsqaEmH?=
 =?us-ascii?Q?Ji/K/0pChebkPG1joZ5UBvIF+5VhgmYnighGEcTjxcgCtUi4xkzK1n5LyUM4?=
 =?us-ascii?Q?FMY4Ezkm81ZzbGYWW2jvhLM2Q09iXhUwNK/jocdZJBqGO8FEEC3pGMzoHED2?=
 =?us-ascii?Q?JHXDac2F81OpBuKe5Iu1L6FYCnt2XBWCFRsvLdn0/N4yPUiMtaW6FNGoUg8N?=
 =?us-ascii?Q?D9HLtJCvW+zNygI+FQeyzHqgGbKrJ0Bu+W13NN7ri5WlLxDUnWq+OOzk7VVD?=
 =?us-ascii?Q?6R6u5iKVj4Kwebse0TskSAJUUgSwgNjuzJuTyynSLu9VsDWUJ7UtiEmco7Bl?=
 =?us-ascii?Q?dejEArZDTZSIykB61IT8wqMTKEqvasYU3xG/rcWDC73n9Vf0M9UJtho/ohIB?=
 =?us-ascii?Q?tAKxorPqAihxvFfdqEnygaKVTCACoKTyP8D86G2mSxzomWtWJH4CQzFtPkf3?=
 =?us-ascii?Q?4n98niomaTHA1Khe8Ud9kMRPHluThDmIOb0uFu1pLQ7dWFdwOn+pVm7SSI7H?=
 =?us-ascii?Q?RHLuQZ91vcdHpopmQGmjj5kPELRcqUeA1KJG2RRSTjPvZ73143xuFDvxp3C9?=
 =?us-ascii?Q?lY9JVy1VF6hzKGpC8NyjVTRtkHjRxcClC516Vq5uSgSy2Tu9OjU1sBU1NA4E?=
 =?us-ascii?Q?k1o4N0WF1jzEec4AenfDz+NseZyRdzoXBlCr1RXai6RPULYvr12qw2L6hi4W?=
 =?us-ascii?Q?MVkONu5cK6up1LSpzqUhsmQ/rLAeoObqDX6RGZGrwvD0kvV5HpPyJSRK6xMt?=
 =?us-ascii?Q?htq/N63z3S+pFe6JJybF2zQEI92f+NuHX6i2EkwDBRl8/BMXzkWsaMFsx3a4?=
 =?us-ascii?Q?ZWmF7LRI2HshMR8W/5nhmIg2DoHB6PEE2aeedbo/NUClQI4iqfyuT5CJGsXS?=
 =?us-ascii?Q?lUqHZRo9gAuz1+2Zx1E2tp8OQjYOtl9Frh1ojwlNKNreU8PAvMeOZtZhxLwy?=
 =?us-ascii?Q?VmLwq7VVEIuFannuxdpdg9tClS3dOKsAlIqqotaU5m/A5UbUFAPadnd5fTf5?=
 =?us-ascii?Q?FkgMPfEmqYVgdC160PEhTpeNMhC2fnDM2j/zOBVrmsNOXTKapmq9n3GAfFib?=
 =?us-ascii?Q?mSKIDaDudAaLcSW+tzPExDhsuUx0bPqsk9Gb/uiz3c4ZIh6kmcR0r8u1n5MW?=
 =?us-ascii?Q?/4Z2sdoSurq7zK3DQv9S4fDielQLFDv2L3fx7BrQOXvs85r1x8JLdXSoli2C?=
 =?us-ascii?Q?Ev9T7pTlWgmLFvOA1zrvAMn8JbXFacC2Fk//7suKUbfugQFQew/YZV9e/8oc?=
 =?us-ascii?Q?vUalgJXHh5NmFUDslhn+C0Jdy8L2WqE5Hyjjy0kz85vdBS0XXacZ1LYsUERI?=
 =?us-ascii?Q?Lf85lw39sdKJvTTRKNgk4ZA/7jXXFKMvPa/PEJo+XVCeCV3MTc94YT8Yh6Yh?=
 =?us-ascii?Q?yF0ZSZ/HU7EnA64mukmJGrr+TNybFGqNrYcMOmZqpY0aHyc4GqKQQ7oDk+10?=
 =?us-ascii?Q?GFtxcEVdU/mT2VcWAvnm7+D3Ij8ljyJ0snP5EE3iHFgV+0BqCQ8uwecQlg6c?=
 =?us-ascii?Q?OZRMsj9zTcrNm4Z484iN3Mlvoccs0sWFQP+nTmth0fz92hKF9snaQSvgcokz?=
 =?us-ascii?Q?ULjDI3AH27yuLoxwH9UJyhjETGH4u8gXayqkPayX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: debf8d74-6d05-48ea-e6f0-08dd469de9b8
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 11:03:40.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: in1v+cHazz9CBf8cMnlDEXuuR7iVCctzq1ix83HCc/dsYXWiLngNP5FFX3SzRaf90zmau9mwI1D9Vvbsk3KzpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943

On 17.01.25 15:31:51, Ben Cheatham wrote:
> On 1/7/25 8:10 AM, Robert Richter wrote:
> > For the implementation of address translation it might not be possible
> > to determine the root decoder in the early enumeration state since the
> > SPA range is still unknown. Instead, the endpoint's HPA range is known
> > and from there the topology can be traversed up to the root port while
> > the memory range is adjusted from one memory domain to the next up to
> > the root port.
> > 
> > In a first step, use endpoint's HPA range to find the port's decoder.
> > Without address translation there is HPA == SPA. Then, the HPA range
> > of the endpoint can be used instead of the root decoder's range as
> > both are the same.
> 
> I think this can be clearer. Something like:
> 
> "In a first step, use endpoint's HPA range to find the port's decoder.
> Without address translation HPA == SPA, so the endpoint's HPA range can
> be used since it is the same as the root decoder's.

Changed, thanks.

-Robert
