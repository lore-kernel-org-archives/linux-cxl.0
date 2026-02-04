Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010026.outbound.protection.outlook.com [52.101.61.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0DC156F45;
	Wed,  4 Feb 2026 12:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770209916; cv=fail; b=dtxqki3aKw3RozwANKCYR+G/tNO7S5qXo6m87Ox6wgeaWXh+2DIlTSNJhkynUx2dXp7SZFFXUEWmxaSLZbDxMN6JUFFyyGbA1pGwkTPu8VaaX5WtY+9DLgVqlYDwIy/41LVk16IrR0hyt4SuDZQzOAUS4BK+o4LrL1E5FOWlVsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770209916; c=relaxed/simple;
	bh=mf4PR8ZKrXqZE9P6P+oqR5xPfJEUROnFbNvx+gtnbS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i8yrnYIYzFiop2FceWzmjqoROOEfWdIr6U85qEj0r42oYp25vSqzoqA3t8quliUN7s+D9vZWviYiu5oXGnFZRJ4/u+7P9KcmXVQi3eLLEVN25HvQlP/FoucWvP7uR5e0gllMmP1nR1FBl4vDXgWSuAJFDO7l7Jx9xAs1wIkotXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5NcWzpl+; arc=fail smtp.client-ip=52.101.61.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5NcWzpl+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EnUzKrmK3izuXrNxbKrD7ghtia/4tOqwmojsUI/bqKW0teuMFLgnKaQvcJuy0gd50QaAnm/H4hkHpv4K+exKODak+rB4gjScCbwBsMqxOTvTpf0aavwpI4TX9PSOv40pR8yBYw3dhdweWSQ123gWFFiAs593NLS166t2djdshLBtoerL65TQjyrgqRScDcR/PWB+zIwwV7RNPaRJMSB/R88llspJQkHr4xt++3P5n4ir2sV0qIsc/PfAIJ7Sra4yR4mBaZAXn2CW+wMe4390fbIf/JwEJnakrXD7z0Z0V30tSt7rWoqS1AFb5YDBRAKXTxFIG6qM4T0ZFtzbR+s+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vN7x7K/SYMN/DyamREFfMsWCLa3QTaVkyYo5VutpxQ=;
 b=hKpiBZ7J7GVc9RkMvTCLp98fGU52SHp58ZcoUsMBviS/iL6T4DPwF8gDUSstmg1lGlQBU8seFmz7/SwknsLs2os4z1/Cpbcfj4EtEUud6jn7lu4cm/fBeabiBNPkEMH00azn2hb/maf0ZUqH55tqB9lNuTVUshZoaVSoAIJOutQ3NSYlhBrOda3+acUu9C9m10JZZZlDBDbB9c6Veh+ZkHQJj3COT/JJ9ajJYcelYJCH1WKX1xIbVJM9Wff2FM+jC+ntflEw8nMx8WHSyEMm67NhX608Q5T+Y5a2jg49tF5VLuggrlVV6y46k5tjAvCbjxoI/8FjmplBx8Yb/4Jl2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vN7x7K/SYMN/DyamREFfMsWCLa3QTaVkyYo5VutpxQ=;
 b=5NcWzpl+x3P9HEJHIIud2hZQzpoWRTKE7j42e3loqUEDp8b10PdXnHSDVmAHFv7fpUvGmCU155+5L1skoXurEr8ZRP0WJ/Tl/7ZcQMqE0qUb/RyKS6vUKAfefYv1vPpNaR95osVSVNjCJFsjjMantMdldt7ECkpMVwmRfRshPZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ2PR12MB7894.namprd12.prod.outlook.com (2603:10b6:a03:4c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Wed, 4 Feb
 2026 12:58:32 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9%6]) with mapi id 15.20.9564.016; Wed, 4 Feb 2026
 12:58:32 +0000
Date: Wed, 4 Feb 2026 13:58:26 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v9 00/13] cxl: ACPI PRM Address Translation Support and
 AMD Zen5 enablement
Message-ID: <aYNCciQJwoTIxQgb@rric.localdomain>
References: <20260110114705.681676-1-rrichter@amd.com>
 <125a0a77-b966-410c-b9e4-a7d81e462576@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <125a0a77-b966-410c-b9e4-a7d81e462576@intel.com>
X-ClientProxiedBy: FR2P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ2PR12MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: c7387492-9309-44f0-e7a7-08de63ed19ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?krX3yMA7NitAvEcsvGu9dFsfQzyzS4wUFunvd5/g6Ax/FGtR68sghzraaBTP?=
 =?us-ascii?Q?GaO3K6N8omkcnTjP+6wHrbsbaEIg/eMj9ukdQHqK5An5nIiXInMvc66d6UeK?=
 =?us-ascii?Q?8CB7j/OOapdg3c3Y08uNpZNqwQcnWv7g7/rm1bbFqg2QYL2o4PuqMTcQ6D6t?=
 =?us-ascii?Q?n9aczGVVXNAr9VYaamjwlUQxcmIM64RYzZQlflUmo6AbSBsWB8F/+4H6Rhoj?=
 =?us-ascii?Q?L1rSkAkQHNuqnaGjDCuQrZydwxVN9q3zeqGXw/UX3bguMRLYUppMYkEvie+d?=
 =?us-ascii?Q?Vh3JN5WdkgSNYw7odFksPUdUyDzOJf7rhj8TCwYkGhYZd55x2RL+H2Qhr6Y1?=
 =?us-ascii?Q?CbNnypMbfhng8t5uR7qsfbjfrYNisC/KAkHj5Q3QwJds2ZtgUc2CAbKcENRx?=
 =?us-ascii?Q?9ru6DfXMRwk+aWjDlXcFsjWHC3qfRODzyWWvRxoIMBtAoEqg5gIDX2eXfMem?=
 =?us-ascii?Q?q6p02PvxVNsOUfl2MWR4xKtmEcT5LrZ5lsigj4KZS39CnDjOzGRLdckSgvqR?=
 =?us-ascii?Q?+Fb/bpFcDGqR1XPDIAeG/AwTZVASUlEnRZZNE7B7TTdTO2fcJ8lud3NGR2gs?=
 =?us-ascii?Q?V0wuB3rw3s01CiIWBEXaiIGVWnptfrwgTcBVsX16i7IH7ovmsuxsP18Si3Gg?=
 =?us-ascii?Q?frxKQ3t66lv0T6wR5VZTmVz0Tcn8XmKYA5F8lTe006mY0vcu+nyPw4lsmqSU?=
 =?us-ascii?Q?UfWMT/hDm+2S0tBwjmH5UlKYB0o6o17bAtPQ1bpxydpXeV15uq6qU9fOpWQq?=
 =?us-ascii?Q?0zDqIKDf6hof2N3STyM2/2EPMu6SPMdD7Rf0hHFhGWbal3g4rJuTIvimvcY0?=
 =?us-ascii?Q?Z3xOiAth0blF3WiTrU4FXjwCrMyzqNxTF7Ux0/y34nHO2AR3IoVrtrwzFUiY?=
 =?us-ascii?Q?lfJUDs7w7z4epAHJo40Ms/fJCJKFYuYHhJj1lBrmtDz1Q1A4MHRLQdSwi3qW?=
 =?us-ascii?Q?hx745HNgsX6huFD38PPgGCFjS8AkYk5lFNHPlEy49U1PW/g1leZ50wcE9Cjf?=
 =?us-ascii?Q?1JjxSG+A1n/3Nz60MqPPvHb8aJx0LbOEN4SZ8eGzO0Y7g/Yitd0bcDDnWyqt?=
 =?us-ascii?Q?migQ+bX/mB2NrgxQg/h/lzzpVZjGaL8mIi1Ph9Cry3yaayiY2BcXNAc5JHNM?=
 =?us-ascii?Q?F/GUaTBuDruAwhTvtiKFgcF4tpug7mvWrn7DpDjlpirj+Tv2P80TXsNh/dVE?=
 =?us-ascii?Q?uYWaMo5yblWkjK8QLzkjSSu1QWE+ydbTKP05i9kWzMga241ScJVZs1aRxxqG?=
 =?us-ascii?Q?vAMrXyudZKLzUApcPN3gGx5FMLlq0hvPWHD/ZRaKlDLtrUuy1vIa5H2epMne?=
 =?us-ascii?Q?vBKX0grjwZd6Gs4YTeqBAyMg3d87dpduWG9fX8lIqupgkiLZe8SXrCnwnDAZ?=
 =?us-ascii?Q?jpQT09CToSeLPON1887KXRp/RUa0pTp8tnI8L21NOcbO2hk4wRtu36VY98j4?=
 =?us-ascii?Q?ugnhNbqtg9cS/zlhtoeAcmm9T+2jvEaps/I+2swoqPgIkeuFKaKWzmxBXQFq?=
 =?us-ascii?Q?4MD1rIU9IlmsjswZ/S0vlBEfVjRgyxyc25hkIIiEZ2SY2nJy25oIw+l3hWzD?=
 =?us-ascii?Q?M5OLTRCq77Yc6Ed6ExU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P90z/qUHTCbsFXxNk8usZVgFRKQDw9ffNM5XOOQvPsfpsEesNC+HBLtDXqD4?=
 =?us-ascii?Q?sI+0LmfRHlFEhufTPFnFG+re+EdinKmJmP5ecbCWqKAgibwnCOGzpD8xnB9x?=
 =?us-ascii?Q?FiEiAXnu9Jtyxp2gqBlXRTS+w1J7GXCRz9Qerpoc4mj7SIaEMvg3e/RAigba?=
 =?us-ascii?Q?wn3SXLPM6TT3XDsJZVnNtIupDcbdxbf6o0uhVvdpSpo0MpBb8W/gU26C8wJu?=
 =?us-ascii?Q?MnNT5Q18ccQUH/+KBTD6Dic3dnW/CxPzt0mLNQM6epTYrBsk7fAy1x+Oh1Y2?=
 =?us-ascii?Q?XEzmyOA7DySlWgy2151FLEYIk565n5Zp4iGf4fGttUDu93pdBiYEWGqFe8xO?=
 =?us-ascii?Q?xtjEFVG6pPqYeHXP4ehKp2pot/76edXhSJMlF8nIpv6CThVb6cBUO+43co08?=
 =?us-ascii?Q?m8PR9iJXfXWBcS4Efq54893HszFW57wl6zZSrtzcG/cLylXRH3ZI1/1iKgNH?=
 =?us-ascii?Q?nzrtwhJlONJjApSHV3moDBBF2p6+8mamXOqpot6ZMKN+bAz2SRHF8nE3qwJe?=
 =?us-ascii?Q?0nibBvWg+Z4rTjvxmHvbEgjq1a5LDOm9awSkezSECkUjzi4bVr+5BXi/KmRB?=
 =?us-ascii?Q?CQYGV//iTpYcMmQj6JffaS9b2Vytn3fOnO9CRy2ZgKj12XlpfLDkR5AAR8s7?=
 =?us-ascii?Q?PjUaJalyKQplTXuYHMiC5ZJnrmoaqX2PqfljDB/T6B/sexVsFXPTy8I68x4j?=
 =?us-ascii?Q?qC7z4Fes8F7eFNKDt49iZcGwscvaUSwKepBP0bMPivKtlMBjflErsP9Xu2Et?=
 =?us-ascii?Q?+3MwRqyzbrZrtixbcYvi8zIMcls5aO+LqEMiMdYPRGI6ycyv6Gp5LxkYRG/h?=
 =?us-ascii?Q?3WSDDulWf+aPMVEprENod618xr03AWiG9fdloVOXlLuXhgSN4T9zPhhxPHeF?=
 =?us-ascii?Q?dtshUCKL0aqj38c7SSYrcfgCqtkFkRChupYYzn7rlsf9UPaizml/397scJR8?=
 =?us-ascii?Q?Kw/EzviN++ENZI9640/4tFHA1nYgUWmNuesZfCjU/FexvE836JK00mPgW86m?=
 =?us-ascii?Q?zp44MM99RXOLzys2sFQ1TFQ06HpS2TmOOpjzFnysdZmigyPaG5KUiXSorMRi?=
 =?us-ascii?Q?uZb03xwyk8ZobwDQ/5SWXTB7dwH7Wk5uf14ZvT4iscl50JhSYPGxmVgUOpdz?=
 =?us-ascii?Q?fqllrEfE0LX3BA89cB9gNxX3nDnoCWwmtsfgWnz95cVQXQfuWrv/NxjoUYn0?=
 =?us-ascii?Q?2VkR46G9RIWZeRMSxuuNdbjiaGCYHc4B9hiA60tqnf05iwctuzVELkym7a7D?=
 =?us-ascii?Q?yEnqZw+ffFpG2yALbb2EmahkSdTXPCjvw3z894tCv76LFRzthcjh2ZaAKccT?=
 =?us-ascii?Q?Z5/3UngYwkPhaVhUi7c78TV7l4rqVGeMR3WrZIABq2S9aZoVYnqFsjM2PGYt?=
 =?us-ascii?Q?Eg2f+/UUaWllBgL8khZFPR54v3XSk68o3t+QSWnJE0RggIqwdxQ8OvIBzxle?=
 =?us-ascii?Q?9mVqAv0bUvv6dPONm/JdAP3UPjnhgcbn6ekDa6YnGO6igl3ZI+0t90IKThZq?=
 =?us-ascii?Q?fgN4LEOKYyNaJ79oowajurMPFLOWb79jysqerfdr+LCuN2jkEqkEkMkBvuFn?=
 =?us-ascii?Q?FFfxzOW5rBcEF8/laKHuWtyRVg6iT1PkURGj0mi68/1/hd3b/rCilNk7pscd?=
 =?us-ascii?Q?YQXCVlrQXuxrXUcsIpxJ8Niu1p74PLI0CF9lDSB5HmjW3UVygrAVzBsjAabm?=
 =?us-ascii?Q?P2O/SQ86DW7I9AW30A+m2jKp9O/i+G/Ex4X0s5QK1Cs8HTHp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7387492-9309-44f0-e7a7-08de63ed19ad
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 12:58:32.4775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: buGqJilOQO7/8HMAMdyYu84WCZf+UyOG+S6gerZGDCZyuGjMLkDxGMXV+WZfVUPqzDNxJsbq+fOuGY30IXrLtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7894

Hi Dave,

On 03.02.26 11:52:02, Dave Jiang wrote:
> 
> 
> On 1/10/26 4:46 AM, Robert Richter wrote:
> > This patch set adds support for address translation using ACPI PRM and
> > enables this for AMD Zen5 platforms. The current approach bases on v4
> > and is in response to earlier attempts to implement CXL address
> > translation:
> > 
> >  * v1: [1] and the comments on it, esp. Dan's [2],
> >  * v2: [3] and comments on [4], esp. Dave's [5],
> >  * v3: [6] and comments on it, esp. Dave's [7],
> >  * v4: [8].
> > 
> > This version addresses Alison's review comments to change the
> > implementation to disable HPA/SPA translation handler. There are a
> > view minor but no major changes otherwise. See the changelog for
> > details. Thank you all for your reviews and testing.
> > 
> > Documentation of CXL Address Translation Support will be added to the
> > Kernel's "Compute Express Link: Linux Conventions". This patch
> > submission will be the base for a documentation patch that describes CXL
> > Address Translation support accordingly.
> > 
> > The CXL driver currently does not implement address translation which
> > assumes the host physical addresses (HPA) and system physical
> > addresses (SPA) are equal.
> > 
> > Systems with different HPA and SPA addresses need address translation.
> > If this is the case, the hardware addresses esp. used in the HDM
> > decoder configurations are different to the system's or parent port
> > address ranges. E.g. AMD Zen5 systems may be configured to use
> > 'Normalized addresses'. Then, CXL endpoints have their own physical
> > address base which is not the same as the SPA used by the CXL host
> > bridge. Thus, addresses need to be translated from the endpoint's to
> > its CXL host bridge's address range.
> > 
> > To enable address translation, the endpoint's HPA range must be
> > translated to the CXL host bridge's address range. A callback is
> > introduced to translate a decoder's HPA to the CXL host bridge's
> > address range. The callback is then used to determine the region
> > parameters which includes the SPA translated address range of the
> > endpoint decoder and the interleaving configuration. This is stored in
> > struct cxl_region which allows an endpoint decoder to determine that
> > parameters based on its assigned region.
> > 
> > Note that only auto-discovery of decoders is supported. Thus, decoders
> > are locked and cannot be configured manually.
> > 
> > Finally, Zen5 address translation is enabled using ACPI PRMT.
> > 
> > This series bases on v6.19-rc1.
> 
> Applied to cxl/next. Including the conventions doc.
> 00bc604c96bb762f0f050460e25de2729edb1699

Thank you for applying the series, I noticed wrong authorship of
a0a135b410f57702ac6a463005c656f291eb7b90, could you fix that?

Thank you,

-Robert
