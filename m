Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011031.outbound.protection.outlook.com [52.101.62.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40F21A6829;
	Thu,  9 Apr 2026 18:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775759173; cv=fail; b=j7FOHt7vv9Z8o0hv/PARkdovzcLreYjxMdT2bXqYfhSbF7zHqMaxNwa9N3yM0rWG/SgpfskyLRaTkkyZfFbd/rqGRX1mAidPSX9OnUdcGvRSXTsQl8VDnlHkzs7V17GfqXDMGAW0VEsp3QJo8Nj1gRML5PBMuHsnM+k+QbwEkKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775759173; c=relaxed/simple;
	bh=t1hjifnA6D3RpKEPQQKT//hw02EqRwamH9dP+B4GOiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UVJtz3KpcCaZLw4Jsnb/Xnm+x+JwF5vSnoyDA449G3bJokL9z6fS6bWDhMgKfPelRAma7ZsH0hoSjvwJ05UzElpuL1PmNyxsQlpIdg+WTwv9tLO0N32jQj6J/iC5P4+0hCRojZFuwTqS0aCuyFi2QcGtdIAM7SE0cGGiPl7/3eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oPVxQMfH; arc=fail smtp.client-ip=52.101.62.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oPVxQMfH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kH473QRmVjUDvvmIcUr4Gd57d9jYxK/7azCY2hlDTkJEioG9wPqDZ2C9QL10XZaMzH2HNZh9A7pO2t8dFpG0TiXP2Ggjd6YrHcYpyAgmrRgbQwdRP07NLqFb1wEdzrZ99bjh6ShvcvH5RhUrRWeF+X6NeiIqfIUGN7NJJjemp3BpUM1zxh8WRGgNEp5uI0/iit6kItcgppAlZ+p2Za3J3M/4b7ouiZls117bMyWOjVehz5ExBMroU2OutarJVFDOKLBS7X0SZArAx6dUASrPPNOKgKt49inxeSiOD3W9gj0RdjX/Qvt6SfwFPuzatQJDBpkIaXa/NrgxGjQgZ0thIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1hjifnA6D3RpKEPQQKT//hw02EqRwamH9dP+B4GOiA=;
 b=wCd5oO5HM4KHs5LqrSZShltxAISLPft8fPlai9elLw9O2xfsl528Q+BTYM6NBapksS7Y+bjDs5/YdaKfKKol5G0pb5537WmjXongZykR3Y85TArqUgnjq1fiZp++7tXabGYkkQSoOdjStLde87aXknBp5Ez2mABzVFS9sfhjDCNoNQ0DaTdAPT/nX6xUU2bgxL/sxcvQOhYjXoh/+WsX0Inb8n2p6oXbNONtu2NQmyzvG+1f0oxFON+wQThQiPWj0KX3uQbcIY4+Z4HiMVZf2bqExjU/LOUqaSO/KWVHSXPD5rJlE+BkPtREXcpmbiYm6YHbNJx1ZKbhmx4TYSSavw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1hjifnA6D3RpKEPQQKT//hw02EqRwamH9dP+B4GOiA=;
 b=oPVxQMfHtu9x7Qr375lVm0yrHRQs7M/D9i2JKHDSwjHzk6ev+i5iQD02vDtVkwdgWnsbU3BkXoBq8M+172YpjZqHW64hpafsmhsU/XjrQNBnWl6Jv+NR7DoRFMX8SM7z4e34CaRQ8462xGjAsGEgO0zfqqD7mWGW7CBiS0a2kEmDTOuL3apV2/F0/yv47YA75K8FdmK9LEkzMRj/BwHr+uJhmxz/iLqTGNqM49izcc/D7/UvPLDf3YZbztNKbHHHk3ybA216LzyWuO/I51xnipZ9ICZlur/c5J3xdmqeD75vpv4R3SRjsDRXWS2Enpp0jEalQtg54memXsGTZpUlDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHXPR12MB999244.namprd12.prod.outlook.com
 (2603:10b6:610:2fc::17) by CY8PR12MB8337.namprd12.prod.outlook.com
 (2603:10b6:930:7d::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 18:26:08 +0000
Received: from CHXPR12MB999244.namprd12.prod.outlook.com
 ([fe80::168f:599c:f74d:7688]) by CHXPR12MB999244.namprd12.prod.outlook.com
 ([fe80::168f:599c:f74d:7688%5]) with mapi id 15.20.9791.032; Thu, 9 Apr 2026
 18:26:08 +0000
From: KobaK <kobak@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/region: Validate partition index before array access
Date: Fri, 10 Apr 2026 02:26:03 +0800
Message-ID: <20260409182603.2438631-1-kobak@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260409154445.2416120-1-kobak@nvidia.com>
References: <20260409154445.2416120-1-kobak@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0009.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:9::8)
 To CHXPR12MB999244.namprd12.prod.outlook.com (2603:10b6:610:2fc::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHXPR12MB999244:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: e459cc3b-f7d7-4d96-c707-08de966577e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TT+MXgV5vKztMXtYEflCbcwGWUhzeh+AQTGenF98nASQ9WAmJSzT5fHtdqZdVKR4UCv1Z3BCxaOsYnVwGRJ790+OChI+kNL0SikzE4Lejs4i1LDanDAaomXra6jua7VHpE/HntuIm9gsOjVkJup0b2t9zMtMBEZZS69uUT6C3MZ/IwpYd2VFfuCExFj4uIssKhdwSVo5aPktchQi+NaONztd5r5fgJsGvaUEZ8P21QXxWP9F/I8bPpf8iESldeh90fQLnex55+xnwZUZN4WuwpIEjUcLxZkDh8dPUXJARZA+UQbT8LCMXaSzSoYL6qVqFiTi28gAypdAR+laO5pCjHps0htsC7EuVL+t00hg+X3agVYyNvmRLe2ygj2XxWvEha45bVmcCLKTfW/OY+nBFKLnW/U1GP+L0lSqzfb5nPXMKCFYhe0sMFpD9hZyhQrTxYj8dO0LlZoOoMmuWlT5xjTjC7wcLTlOs1g+MDEP/1LvUHVfVe1RhokvBq0gfTc5runfiWZWwifFbrFSE0smOwBPBH8TsYyeWlmS2wgX+kyAhIfPbB4wCLfhTnIpji66KPrtGXxoT/3nVKKkZ6Fz+vlkiq6fkSnMosvsGTbUl6IzBFwadrMtzjta3b+5I450R1VwVPR9vW9+UWl5Jz//3oSaSw3dNB/IIGbpxaADf9r74go22dUKUvgTHvN0Pv0nLzYpzzhSFTIyjmVYgyqO495mwxTarj9xfyMuRuMim00=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHXPR12MB999244.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Gkd8Es/gjVYGWxQO9598K/htGP+CuKDprBhEBEK2sXPM1ii4QqXaq68KU0ut?=
 =?us-ascii?Q?lL03JD47g4Mpl74krbGwddLbje9yTIQzr8xQKbZ/q9i4QXYSXEqpvEjPiOEy?=
 =?us-ascii?Q?2ZGbFzsoJqOi0+YOzwoiRWoLXTvfCnf7zk4S2Jsks45Mli3Md/tOHsaGtnAr?=
 =?us-ascii?Q?XobeIhD/7EqKaOkES/I4Wj9TGWiz+N1r5kUJ5NAUg2RrdlQ7JiubkeMvffkw?=
 =?us-ascii?Q?5ssd52CvcLDKxwGj1OvyOVYedPtjjgH25zhp3ejVnAWd4K0iCL8tUCqT0t+O?=
 =?us-ascii?Q?oMfVpseZJ3/g5VzMgMehdaAdh2vRa1dBq6oFojbe+HdAjemuoFq2HHl0Ourq?=
 =?us-ascii?Q?HRwMELKAOkzcc319dWN5piXJ2E53zMlOYONhDoen90jssEsTgKqcTuSaQAo/?=
 =?us-ascii?Q?q5SgjN6LBNzaFkCMsFa4NvNVYcmm+k2/5twQcZ20VUQjFCtpJZZ6ioLdxGW3?=
 =?us-ascii?Q?bLRlMl1IC03ylHQsNsmb/zpUfugU0DQgfba+V+JSN6sP7rrK4++aNXfLoSYj?=
 =?us-ascii?Q?uJxQC/M/08nWN8wyW1mqvUMVxCnc+8AuZOqM0Z0xn2c5e744DAqCe+d/zifH?=
 =?us-ascii?Q?qNxJuGlBZixj92hK6DAg46r5x/35/NuWSQK9KSg5ihRZkQfX58G52XtOW10w?=
 =?us-ascii?Q?ByIdVm+cahbxXX8vbUqrsjWKLl+tt16fCuw+dOM0U2QY/m0/MOXo3ecit9Tg?=
 =?us-ascii?Q?1fUYMbSyWzxsUQso5IugPgrHuibIRlRDUg8UXW+A+2oK8YB/z9UuvQVFL9iN?=
 =?us-ascii?Q?datSjkT+Tt68jMlIpXy56X0bXdnzEBUIlG/7kY/HPM81up/92KvBmxeVUy2K?=
 =?us-ascii?Q?Bk33FH5Ba8UPx4YQ7iHAu5ASNI62Ip5m9j0cAePpsRxRuzkRCw9ftS7l6DKa?=
 =?us-ascii?Q?mRfxRVitzX5MxKDK0RJlCLl+9j0oZRptJT6ZQfvdkC3FiUryqsHEw1sG3Igp?=
 =?us-ascii?Q?zdMPBiPV5nQPUJCOoWuXblgaRz/lO7cFQcg3HhpdG9x7A5rr1f0rrAb83ZaZ?=
 =?us-ascii?Q?ssRYYh57TRCG1LcYk1ObwzzkY9PQmbUv7Kpqat4E38v+f5xbIkhYr7Bej6HX?=
 =?us-ascii?Q?SmJVYqqERhsxbJEuBrd0azO+st4FE3uVIUa0NhUfQF0A4lIifE/acCMj1GP2?=
 =?us-ascii?Q?7IggzESs3WXpWy7pNXWGeg2Dpzkabrid5UO6caumXamUucawWKxUpY+t0je2?=
 =?us-ascii?Q?1RoPLjsqoldh76BshAaAxpse7cZtJLE/FyQ4CjAyeuEW5lxxP/L6y8r70r2B?=
 =?us-ascii?Q?sUevok1UO93ZU+nUbzVixp7cLSY4OcJVmqcu6aCwALfI9DoO5PKUnMv5SDmR?=
 =?us-ascii?Q?nVedOuzQeer7k7yy1PJWFsBkKeul7x6LptPr96R6lOAXl3wfojAM136euEAF?=
 =?us-ascii?Q?ZCSNKpwbJ6e/5UjANHNLljqdsn7u1zwQeSlsEYiwOoeoJsRpSCCyfFgFFO0Y?=
 =?us-ascii?Q?CqZkUjb3qlrCWr8AgV4L6UplySu+op70Dzn9Q/7tY0huV6hM+N+/JGcruMrU?=
 =?us-ascii?Q?7/gE6EuuFs0Ae2ciAEX+nhoeJXWXkUgRslR3Eu4SL9R1KdjhOYkBrAtO8Ytg?=
 =?us-ascii?Q?qdknMUGuifuGb5ryCn/r+6IGGEDqDhY8KVJKKjhskX04EUpkE6sxuQrpfxko?=
 =?us-ascii?Q?pqkBYMJDp/Je9yfx9nixKzCnuNt1I2LupCIOrjFHVEO8MUCHKklalnFH9kQY?=
 =?us-ascii?Q?K9NMzODr1z7q4c8nqINso9OJ1PiLvT4Y/48A5NNYRdFrblk9e6AzbqSBUTFb?=
 =?us-ascii?Q?H9uSEXZN0Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e459cc3b-f7d7-4d96-c707-08de966577e1
X-MS-Exchange-CrossTenant-AuthSource: CHXPR12MB999244.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 18:26:08.1497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u59tAIWFLmTPlkIAchEduEnRRUwApNY8gbcNV7tPY/ZI847LFHTX8oQffJ1MoIG1KavhPMqwHNbpIyjiiSbS/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337

On Thu, 9 Apr 2026 09:58:44 -0700, Dave Jiang wrote:
> Was this issue encountered during testing or just by inspection (or AI
> analysis)? I'm just curious on how this condition is triggered and if a
> regression unit test needs to be added.

Caught by AI-assisted code analysis.

Thanks,
Koba
