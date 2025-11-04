Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354ED25F99B;
	Tue,  4 Nov 2025 12:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260548; cv=fail; b=ndTSbOMshkzTC6OfFh860CD0wSDS/vZGO4fVQOMoIfBeD61pSGmy4Z5a9fW/s4bVPUEI7x6nn0JNfBLBs1/oNm/dP0KBlqbgjthpwBrjDTf13nJTDs9mLytGHt/MVHurwYM80dsVv7PfOrfrbsJtOHy9iDXKQ0A0ePHwnOWieKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260548; c=relaxed/simple;
	bh=F3efWc9Ojz5qR/ZY+krxkZpDDKD2XtZZrsyiAamIAj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FYTcCpphhGPrS8AV+mEDD6kl++WxzORZ+fhfIHj1/kzf421QZeSsmEy9fyJbikvAQSvg3TYrCqDfNbJebF97BkajcH/eSwl4nfQVgTCZaZV1qywyJHvbpheO4ggs8TVQOs5JDQuUpEooALkrP3uOGyAQavf+WkZdYbWsGvup8Rs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xYwPEs+Y; arc=fail smtp.client-ip=40.107.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xYwPEs+Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JNp0dN+sxgfvbJIJaLBZ8dDXseyzq3s6M7qfh0tMmJfOO3on72xrQIQvGtOefbyZvUrtFScodQ4bYRowl2RqmjXFK8C39KPnTpyWe8X+SmWyPCZuRZ4nZvbroXHA3qKiqpWkCo6K3oMOQm9uLxkZoZefOg9MkeiKDBXTBn/lx2I68OxUXZRQ3tB7VCZ8e1ng1NeesvwDlyX5paqcrCl6wAZoXiA4H4RYcUO2NYc7/N6XyraBLnOLQaz75UufTLZN6LCtjFSvPSySl9kfEn7EeRTFvpIIaCAaUpNL/mExGQd4YkdX1RU4kcIAXpbA4JEKEDzVLidQhXC12aJSSdS2EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/ZqnnTNYR8IO2yk5nOz+KsE1b+BVveSLAneMT48rN0=;
 b=Zi7/dJ4JHqOC8D5xeVV24VVV1tbpxMyvsX8l6GDv036sWXh0efIiuG+gcZ7BsF64UrgL/rQSKo/NExBYsAO/SMZZ0XEmdgFGuKDYCQLECBkHyUb1TrDUa9DZDVEmEIXK/kuXSQHpLJe2j0azkPbBvPTGzp6N1NhXoM4wgilHCEXNlG9AdKL0K/jtf/HT2RW3hLhUEDNQ2dVNZW/7WVLZeQamDkq4H9P2bp6Z1NIZXpe8jm5ZSeOQmn9p87I9CGj/fKp/s604gj9GlUv3DFxp4pVrC05wz/dEnYRvv1oE8rOaIHhq+n7hoHl24IWcrPMn/saihGG27H/4fBJKPzSpQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/ZqnnTNYR8IO2yk5nOz+KsE1b+BVveSLAneMT48rN0=;
 b=xYwPEs+YUn5VEGVK+mmgvrbi5j2AEaDlIHkDkJtUvE4/A38BjDzzBxXbB87SWyfrcqr9AsI8QYifFNOPGXY2+vlzZ5UI7bhnoQvct5O1WGKiKL3Y1epfSTpUj72td6XdWL920NN7nGkBMAQ73LOH1JtjegWP9ERi3ImVZZ0K9IM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA1PR12MB8918.namprd12.prod.outlook.com (2603:10b6:806:386::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 12:49:03 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9298.006; Tue, 4 Nov 2025
 12:49:03 +0000
Date: Tue, 4 Nov 2025 13:49:26 +0100
From: Robert Richter <rrichter@amd.com>
To: kernel test robot <lkp@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 10/14] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <aQn2VsXIc8t36fqj@rric.localdomain>
References: <20251103184804.509762-11-rrichter@amd.com>
 <202511041721.oCz4BaCp-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511041721.oCz4BaCp-lkp@intel.com>
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA1PR12MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e9b549c-5a83-490a-09ed-08de1ba0888d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nu6z8WZ68HOyb8guy07voTDrqkP32flV7TzGSBP3O99XOd7y/njr6DRLGk+c?=
 =?us-ascii?Q?UMrGKtk7ltjV8Gcutgih50mFF+Q8IVgH2KXTJVKZTbJYb7tCaXvbXg5ofJR5?=
 =?us-ascii?Q?/MovAQyO+Cj0ajtEykZWForGug6GvIuz3ufmEM73LhLREGxfUjMTIqyl4J03?=
 =?us-ascii?Q?CHZkb7Y0bfDSJLOrVmtvqk9tUgQ7lITa+iIFl1h4cnwOQALOE4nFm/ePOVIQ?=
 =?us-ascii?Q?NmbDMPIqKvIBdERC25iVpPZ09vKeQW3VfmgOBwktWy3XVxA0el6y9ZfthqpS?=
 =?us-ascii?Q?epTjcxpzF9707nZCqfSBV3SJXHuTuDy5SP2vkPB8msxT0WRE/PL77m1tIrzs?=
 =?us-ascii?Q?6ri4QhBYSxdpAaXrvl/L3xmqPy+YXv3XOkRm03BsdduSI9ImvNCjp6p5w2bx?=
 =?us-ascii?Q?Dchrd1OtlMn2ZX3oq5PqfaeKPgt4Tslj09ytXhfqHm3GUpuQ0CJbP3s1rgIl?=
 =?us-ascii?Q?tZx5CMlNarVRFYZl4gVVbX7c/DSmStVeyvSurJ5NAVfdU22zzSUKOoqzO9No?=
 =?us-ascii?Q?wAoDMfSaoKHIrwfvwgidUQDZWal6ru6prrwQ8HmywpqRkk+hmU/YxlVLnNvu?=
 =?us-ascii?Q?mXNyDG9hKKrNib51dXq6Fh4rR4b5BCQVYO3I2N9iqHuGBiXMlYmLIefN23ch?=
 =?us-ascii?Q?yCO8LzogB34A31XAnetrf49JhrKekjNxnBGqzGCDJvmN1yzBUdySA4ezBVLE?=
 =?us-ascii?Q?tKKyt4YTloOOIp0lm8nuYU+/zvxax+U1Meyv+b3zQY2IjBT2Pbfks+kake3x?=
 =?us-ascii?Q?erbMwbkRC1vTbAtuSj1uj3dT+eNnzjrxQlmBAgfcxDa3WJ4tdR9NekzfqOnu?=
 =?us-ascii?Q?qjtSJcm7BSncTUugg+8xfWBBeugMFoVa4pGde4DT3GfGfTRODhGL5ac42d+W?=
 =?us-ascii?Q?rAz7tW3fQ0gKB92onFFSs61pfhcBiajwlopMM+dqY6V0PJcIPyfk+FD9D3Hh?=
 =?us-ascii?Q?R1pqNvQcYo7d2UIgOiOQWdu8zG8jlXrSyGuic6TAAu9XK9hL4s62PE365wiq?=
 =?us-ascii?Q?Y8QO9RmFpvvtjz8LLjO6+5LV7tt/LxZJDJnPOW1MqCJtWoRNmaVAvLT9V+1M?=
 =?us-ascii?Q?YanVbsYXMl2JfJpLT1vZrQ5S2/BTFvYZvm2U1AGNd836sb2bQ3a0dEnobIIQ?=
 =?us-ascii?Q?+qXW2TTPit5V8VL1QOafLfyouGMLIm8yJOTFLDXl9gejoec2/W3bjyKlgI7Q?=
 =?us-ascii?Q?0z3PtcVokg4sBZLtWy7/zBwzrQAoJ3/npY3CiMyfO6rNGeinRUP9vJ5R/Do2?=
 =?us-ascii?Q?k3kKmuAJQnAqKNGYF0ip+11Dv28Vm7rOnAJei+i9r3Goq3bZrDCPcMOpSzEP?=
 =?us-ascii?Q?wyQ9MoDB/nruh5UIn6cQukSnky91xeVIkZNcYqZOIprPsebOhyTCZ93orAFA?=
 =?us-ascii?Q?Y3M+MMWflCkInCPDR7LvYJoQju+KxXg8zvrHEojSyfdAy98qtzdMqu6yTmgM?=
 =?us-ascii?Q?POGWjEIH+V4ZiXVzeT0v0OkpuEpwK8Cf/04+Z84Wff0V84NEbW6A8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rWITgOzYX2znzYv84JTZcpNTY3SFUpI5GNvvgSfs26zfheqcnAwFmJdcy0kV?=
 =?us-ascii?Q?l44Z+0Y//MeNo04HgyYC7qEdp6CLctEUr1FZzM6EyEe15DqjZrWhnQh4pQyb?=
 =?us-ascii?Q?o4fNXSeMkhoWuedRyV3hI2QxgsLqCrU0XAbmSEuHrlbg40CMd4PhyvGc02ab?=
 =?us-ascii?Q?mE4oA83Lld1UoTqofC9yA0X7SIyq4u11XPjJouMFXU0vnrLDg3YkpsrE8C3b?=
 =?us-ascii?Q?4u1ZyEg3+EUq5cuCG9E0pr2jAGk7GZOVDFnIZC6EF2YWGt/GEVJ7XtbfhJWA?=
 =?us-ascii?Q?bTS3YQU7ne7j/XmfoWfGNJ9BAzAg64Iwp840CBCF3J1VfCnKiIiPHFYmo9hy?=
 =?us-ascii?Q?jE802aOpak99mVnJraaH2oHXYYDaedU9NODb+e6aVMs6mGQewSe61KzBr9sE?=
 =?us-ascii?Q?VuKVHW3XrD0Q7pX9AbjGU5j4577k9IRktKUgQvBUGFqFY3XsPxpa7jRPyvUx?=
 =?us-ascii?Q?ex2Vp5+zVeH0APR9tRE4Nkq2BI5zK0R/nWPOXZiJysnZ6C+99L2VE7xHSMJA?=
 =?us-ascii?Q?hBdUNrwzitMBvUJ4Jxk3Pqw84GAOBO06Lxqc9Ho8gzqFMl3D6Tvr0BV8tzy6?=
 =?us-ascii?Q?0uKj6lK+9AA0gnCTmGsP8Q2rZ6ps2ApLIM6ItVjAcnBXEpxhylXbgMxAJag8?=
 =?us-ascii?Q?6riHJDo1M9fhPxN9CukSIdfhPWKfkmN3CAZZ+EvUL/8vQpaItOVs8DReoLLU?=
 =?us-ascii?Q?rD708CTUhDsO92U664oLwDnhvdCV6XZX976YInjMASa2GNPU2LeZ2VShg47l?=
 =?us-ascii?Q?GngfCx8BNuZTUuwxqGglH/CcCLmmROlqZWn6t29qFMNJR3vTLZjLgl0TAOzR?=
 =?us-ascii?Q?Wlt8Nth2aN7VAUrj4VsQzaMLjGjyOkAsaF7SahRKO96lI9yv98EWclpT3daX?=
 =?us-ascii?Q?yRhAcX6Zyt0XQ5shLi1ipgPr6TCbwc2iFLZc+YJYlN+M23bu3Pp+QVYVv58D?=
 =?us-ascii?Q?wIy3mF5mVVRwHBpY5IwXVVKFM9lkNn6vM7g8K0YLZbHGYPnLslz+4akfIxoC?=
 =?us-ascii?Q?L6URESMpxI3BS34lAGPP3z8TowMDjgh4k4xIC88Ys5lHu9XmfCpMp9XRxQOC?=
 =?us-ascii?Q?sRpvoFDIGYgoWnsDcNGkF9VW7FWJgxJevMOeaIzWC8qM7DpWwrgA+TD7FewY?=
 =?us-ascii?Q?wOsTITYaXmSxZFKgjoBZUrxZa0WH4H3V9JZT06mh95lVEKKI163ML3/klkRW?=
 =?us-ascii?Q?GvyfTEmd3jnBggfQZ5WlguWIvc1F1TxAhhpWuI46zAWXyre/YoDgUAHDlvIi?=
 =?us-ascii?Q?yCEcZrtSrSDNfFpHWOyovgDQxTxocFhWRIa81X3ogP1i3upBJSEJEtvRXCdL?=
 =?us-ascii?Q?KBRGXIeaQfF2cluNeDvKMFlwnCiW3DAiJduURifBYBBRQFjjA8qkftOKE9DX?=
 =?us-ascii?Q?cJteiVNx+Iw13WACHwweIt+ZiY3FhnZR9mIg4GYd0iTCbBoYErmLYDj3lpWs?=
 =?us-ascii?Q?o9SqwFC+NsS2q+1LUyBPbdGYwUXE0Pp2onpwRY4sALIQTOWHeHQE49DFvvDB?=
 =?us-ascii?Q?n/1C3HficXhO7orKjKSI6Fyy7I4HUQzvRNdt/ovVWQ/AOWssqu506ztPCH/b?=
 =?us-ascii?Q?3ANvljK1DIXh1Q+SfAs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9b549c-5a83-490a-09ed-08de1ba0888d
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 12:49:03.5315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1++6D8kjvh03fAVNyg1DYskbq09jPuGNxhTja94iuG24CZc538s3J8w6AmRdQAHzY2/ki82yVsVzNV2Jd+wjMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8918

On 04.11.25 17:33:06, kernel test robot wrote:
> Hi Robert,
> 
> kernel test robot noticed the following build errors:
> 
> [auto build test ERROR on 211ddde0823f1442e4ad052a2f30f050145ccada]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Richter/cxl-region-Store-root-decoder-in-struct-cxl_region/20251104-025351
> base:   211ddde0823f1442e4ad052a2f30f050145ccada
> patch link:    https://lore.kernel.org/r/20251103184804.509762-11-rrichter%40amd.com
> patch subject: [PATCH v4 10/14] cxl: Enable AMD Zen5 address translation using ACPI PRMT
> config: x86_64-randconfig-072-20251104 (https://download.01.org/0day-ci/archive/20251104/202511041721.oCz4BaCp-lkp@intel.com/config)
> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251104/202511041721.oCz4BaCp-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202511041721.oCz4BaCp-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> drivers/cxl/core/atl.c:63:42: error: incomplete definition of type 'struct cxl_region_context'
>       63 |         struct cxl_endpoint_decoder *cxled = ctx->cxled;
>          |                                              ~~~^

I have a fix for that which will be part of v5.

-Robert
