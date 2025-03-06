Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470EE191F75;
	Thu,  6 Mar 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741252620; cv=fail; b=t6VBrcbWdwAFND7gQSZrFDuPHDmrWNKq0sNRwH/rMpO8/dk1Tum2Ma2wG8jQtLjNSLXQpmOWv99gM4Wut3tBCsUfSgQjAZFLutP6f2pJxN3gBUpBr/HWQSEaFB3hJw/qj3emsEUJxZ+kpjkDZM+s42RMJ8XGiH31e4zAW+WEbZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741252620; c=relaxed/simple;
	bh=FK3J2r062q688/WWXG+C2MXqJ/pamv9s38JjWKLZrZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ogCEwUCieKdktUVoFdBvnKBiyyms2oaQ5kkPY9DiO4spFNdgInn+lO5EaXb/xZZaVml7zcRBn2ANt8xrQGaoZ+UGD39Hzfqv9c2PH5gi6L8sdmeLcRbtaCXXNDHtfYMHV8t77+aRqRfXGvZjteoHiRAQdB/OUy5sT8DOqHSNIVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YXMfwzlm; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YXMfwzlm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4Qj5IAItKOGtseBytOcl4qkrrMrrG0slRyk9CmeJ5GDfqBTnjgVHT6n0hOQ0SacFIsmdnAkwrCVFPzoq9TzLyuarpNtug2i2gOuuXsgDjN0REoka9VFG/IM8CDwEYNjIEtn/XfxpoDafvC08TubhoJ3Xp/aRmudH2P4t7OQVK3eYi/I711vYkXf+33RpBLCdtGWlrJzg43M7kzolX5luRnivitq7KZgWIrW6CUy3QyghRK+QfAWAGai3RnWLeX6jlbE+gaCteV07pNBnaT9S+OKrFZ+cM3iib2DEj4LRjdUe5tSB96f2NifJi30cFOl5/3Xi59ApXokhuGCtrZ0Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70GrBodj/tjgBUy7nrpnsVDMLpL5VWQp9vHNUamF+WI=;
 b=jdJytFip74V0AGhE9MB98BwhfWTuRDagrYTXOAV85SGLJAX7teM8qCFun9bMzCZAfV2wMvDvxDP8zE+vN1WtoZu02fVjOGND/sdIqmqSyG6Z2MlzAbuQ8UZ54BdXewQFu0BYO9gHhO5AETijQnDPKlpd0XKkKWZ9x9/UtdpVXZe3rmZJrpyxN0nh43WXRQ2vRYMlgXBAwPUCuMvD0AZ4WZa76ZQSONPESylOVYF4qKXswBTbdmjg8NxVYBzl/aSNyZnvmnBULNVPgwIIUhqJPxT+w2EZ5jkrHOlrm4hs4lXHJC6pzhxze6aMTZuA9YUNaBWDPWhIDgmpyr6q2Nx9WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70GrBodj/tjgBUy7nrpnsVDMLpL5VWQp9vHNUamF+WI=;
 b=YXMfwzlmEl3US+0/2WDhGsVkxF9RAXQCOobtKzPauWREVErFxxAnyu9uQg1yazBPTbVSjaZIpmG/btmvle34oT7SA0QKnj5n1SrtUwbTtB++KiHdfm/SavRnQZP5oBqfrK2Tgc2yB2n47zKPlDOTOsvSchHQqZAu0nDzl+7wYz8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 09:16:56 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%7]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 09:16:56 +0000
Date: Thu, 6 Mar 2025 10:16:49 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v3 07/18] cxl/region: Avoid duplicate call of
 cxl_find_decoder_early()
Message-ID: <Z8loAbQJAFQvX-9A@rric.localdomain>
References: <20250211095349.981096-1-rrichter@amd.com>
 <20250211095349.981096-8-rrichter@amd.com>
 <20250214160725.0000662f@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214160725.0000662f@huawei.com>
X-ClientProxiedBy: FR4P281CA0256.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::19) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA1PR12MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: e52a55c7-c8f2-4a9a-4599-08dd5c8fa40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3XlzUhBQXKl1BeC6WXVCngjVq73eeMd4h84DfS2WGQeCTTW09W+o7ymSF+4R?=
 =?us-ascii?Q?VojiQ2nrD8mYksrpBYuON3WE/39ZTqGffd0Cl6q09NHIUUEtRNmVS+EakJWI?=
 =?us-ascii?Q?jkGnu6HVXvZaK3B1f25ThQ+ol3isl4IarGO6W3t3I0DfBk45kvS4A00cV0WZ?=
 =?us-ascii?Q?8M5ORiM4w3txzSP7TCQiJdaZaVuVo+YQq2xDauoU5eOL2kTnf2YbFIuF+7Ew?=
 =?us-ascii?Q?WDSHjakwsvi75ZD8vLf/tZ8ZVns+MUvv2fZXIQRqK57m8/IF/9Nn89sWwdcJ?=
 =?us-ascii?Q?UKyLv1gvOXbfl98M3ZDsaj6Sy5Kq8KtEv/6hL+ymu5MlP+dzm52NYf6zgpdW?=
 =?us-ascii?Q?wvzAoZdP0NzgGEsN44Ki2EhMC2O8xVN2DO4NrMTTneYcXGVVyoolHTwp5tjI?=
 =?us-ascii?Q?qofaCN4VQ1QZFgMFeuiIRZHrFZMFA3pkIEJwbRcYYDz2ylVqvjEzQ1Iy/Sbg?=
 =?us-ascii?Q?ZeEmkjHpXBRkwBjvMggdai86WEW6sIw4173QGAadgis4dqgqsy9xs3wTq97N?=
 =?us-ascii?Q?rAfTrTuXSsFXN38VbyQCrnGj1CdLWbKZ0wPDB6ptdwCD30fxueqz0H9Fue4d?=
 =?us-ascii?Q?MJW43IOsaZ9ARfyrZTGCmp7RiesQ9c0cLrwwFQ4BmEN3SKUtVP2ITG4Ou+4j?=
 =?us-ascii?Q?YHlsZpXf5Ayh+ILn164BxLJ9lz2REGdOIqrVR8C4OWmS0xeXnGSsw+8DWlFr?=
 =?us-ascii?Q?Pxky1djq+dh/+cguKfOAA+mbzJLPbGxxCHti5OEvjaMVQ2+bYGaY4/yexhde?=
 =?us-ascii?Q?4L0MekmldQbVWEVz+VRhHtcTRtJsDdGcuUdE2uCaGuNxT4XXO6aI64jZfMn8?=
 =?us-ascii?Q?d8y4uqs2IhsgGeZF7RO0ULSO0J5EEHbRxwHp8ZO4jdNbJhYHqRbxiGbQn1/V?=
 =?us-ascii?Q?Ht6Qk6+xKkBTxcg6Sh8K7TD6xoST9hoOn73a3ryQvD5XGahsnQpdM/qKT8Ej?=
 =?us-ascii?Q?P9c+/+5Swb3gbkCqWf3R/QxYP2fP/PRptDxFRi/573vTtbOacM29lXcu85+W?=
 =?us-ascii?Q?lIKWSw+M2M8SYyfcOHuF05mGJpqUpHbxP/W7C923lwnfCudra80exFI4Q8x3?=
 =?us-ascii?Q?VEX/qbzBTC54ma+jVH1U4cEd25GO7atv1jDPogdKS/i6gECxc8M9sJZ+Xrvt?=
 =?us-ascii?Q?KubyBoekNMLPqP58v6tV9bSMxMarUC3rGOeTrzKFkryQt5ZpzpJZ3CBfPFXO?=
 =?us-ascii?Q?BzsVd1ziTULYosMRXMSK3sbfFi87T2QUxuM/6O3GYyA0GoqMzy+zxWuVpwIK?=
 =?us-ascii?Q?mRoCuYoGZ1TsHSbGMiDDJNmGC31x4llDK6HNmgfnq8eWlw1eyHResFEsN8wL?=
 =?us-ascii?Q?rWx9Bh4p5dJ9tdIparJTXsI1JDjQorJAxnhpCCKwIfooVYc+JVfl/hSmxeP3?=
 =?us-ascii?Q?7RPYGp/4lXe/ERxVdDKlohCcf69a?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Wzvx1wVby+j46cGyBr0cZPikjHxkAhMao2ezVjxhgekGbeq75BbSHI5iilRt?=
 =?us-ascii?Q?ASfMPCFqQL/pQ5CFEdXYCozfLhXehhpo74P39Cc8CJ0Q74qmiWJZjPKcREVq?=
 =?us-ascii?Q?27Pi/XhgYxvlPoPRpKEq/2EjP6ySrWoyZ1ti2PDk7p/X+agv/ec+GLsmRtXB?=
 =?us-ascii?Q?6xSaHQBxIgeQ4wlSPC+ZMf5QBCjMhvA62VcHmE6BoKWplM/w64rMsaA5HwQH?=
 =?us-ascii?Q?+7he4FcCD4XuWdVjJ1SPRbawTlMQCVZikdRp6Cnp5Bb0ppR+skV/h/5iCCdk?=
 =?us-ascii?Q?stNDVH2fclBhT3WYioeQWI+Vk4Qo4sSVB/D4/BdZRnRw0+WeM5GY/JPCzCX8?=
 =?us-ascii?Q?6lhvqNSU9wjVwSozJFi7AZmkxMcqka3lLzQO38+2owdLIL0AhlViU7qSz8h8?=
 =?us-ascii?Q?rQERkRymZVcpgMCnPtXtJeRYx1kM9rFVMjgf0a8o/ifeCyAIHhKWDyFyEMmT?=
 =?us-ascii?Q?N0AYLZVzkxhpygO+VnA7sj81FfZSF6Iw7SgqvIO0yZ6HVRHe7MdjazZSYpcK?=
 =?us-ascii?Q?H+j1TKB9F0D8+ZXpRzn0mDhu3PU8Z3tyRqQIiCXuI3th3vZZron8wMSU8imW?=
 =?us-ascii?Q?YsOZ3D6POpUcPoqKb40U00tzWGVG2ZqTerBnEiVBXY/7cDdPJLVgUG8or7D3?=
 =?us-ascii?Q?VwGR8br23tCfrcYsY7ao3LtKdQcf3CoOUIEc0nAihu4qZs35ToiV0OBFlVcQ?=
 =?us-ascii?Q?XPymmUufzolELPDrreIE2mWoVZ2iQmCMGw7Uthtbv4CbfHvoHh8L329ffglq?=
 =?us-ascii?Q?M7fNtlEp5eXVysHWP7d971ZoEa9d/SJ9n8uaH5CWYABSrrMWfUpigp6WNPAF?=
 =?us-ascii?Q?+LDm8GAi1eAI3JGR5ROB4kOJhx2fpbAAJbMg8UwdjwWd4YzwKZ7iuDjQmiq1?=
 =?us-ascii?Q?p/GKkKSoWFcD8VW0AxI4xW2ssBiXY0S2dCwNxSYD7BFx0PjywkPRut11yrUW?=
 =?us-ascii?Q?0XGBzplwBDI2hg1OxEyFVmEZ2LA+ZFUV3MWMmGO1weOMKquja/9n14rYMQt1?=
 =?us-ascii?Q?Ltbq9wc7IOOKkslV8xZ4VkG2aQNUjHu+dDiBEJBWDKDU/qt0p0BFJboy+yTA?=
 =?us-ascii?Q?WQXL2UZrZfzd3JQlPPyloI0L7r9bXhXzBdS+dUHDvIS6Kgi41vxBSUzkGZ6d?=
 =?us-ascii?Q?6aIC+PJSveJI/ltoX354mt3l9iILIKK+E4L+Y4iDbs14zxLI5c8sgDeqZx21?=
 =?us-ascii?Q?RZ3Dp/SpWiFwH7HEkyCsRXMg/ObACQ5Vd6L344Tc/E/2rpYR0XF+p+zfBiiL?=
 =?us-ascii?Q?PFSBRE4ot8VbRpihZBwElQH5f4QOolR/74b+GqUU0h2NBA36/iwp2OauwYkO?=
 =?us-ascii?Q?kGBlI5kHeyVzHId7P0OZPUJ3LmC+lmCz935kFgi5x5cEqTUuKqKEAWXiYzGZ?=
 =?us-ascii?Q?J6RnFpW/c28R4K8qSIQCjIUz8yDTc/C8gmRO9nBl7tQm5uk4h+CbzhwNnwot?=
 =?us-ascii?Q?KrOVmkWAPilQBZ1MfAJJVa0W8oWPqLb1uDBNMz+iV1wfTiTIQQsE8C5f6hhy?=
 =?us-ascii?Q?yFeieqYshpNAdfASzRzT7hnwvV5WgJXcYTQX+NpOgKa6TywbCNLZ+w0YFlD/?=
 =?us-ascii?Q?A4DQuEVmdrfRK7ceZVLv3hzK87Yzt9cr0rvpWwAw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52a55c7-c8f2-4a9a-4599-08dd5c8fa40b
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 09:16:56.0848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M9bXfnwP2y86RQhsgMw5bfBTRwCGNTMhfI0cw3Zg3wkk9Ld6IArjfYfkAofb7sA6NYvdDgSoN3uqnk2InRrZ4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821

On 14.02.25 16:07:25, Jonathan Cameron wrote:
> On Tue, 11 Feb 2025 10:53:37 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > Function cxl_find_decoder_early() is called twice, in
> > alloc_region_ref() and cxl_rr_alloc_decoder(). Move it out there and
> 
> out where?  I'd make it clear that both these calls are in
> cxl_port_attach_region()
> 
> > instead pass the decoder as function argument to both.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> > Tested-by: Gregory Price <gourry@gourry.net>
> 
> I think this is fine but it's not immediately obvious so a request
> inline for some more details in this description.

I have updated the patch description.

-Robert
