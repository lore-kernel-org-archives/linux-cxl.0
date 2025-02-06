Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD9B1F60A;
	Thu,  6 Feb 2025 10:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839020; cv=fail; b=cWJtAfGfe+MBNGdTrHhRvFIQpzeNHPJeNmcjIf1EqUFYv90TBS2M+KWkwujvd/Xpow4BcqorKZw3rAzvafIRGx7VQ0DfFFnlmYAgwiGPklOXrbh+hi2EtZxf1FQ8AgCzgPsITRxaboRyLEnXk7dWxM+QVGZitELCvJXe+K+B5MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839020; c=relaxed/simple;
	bh=T+rF8Wi8UV0sTm5pLhGTDLBb7Ns8FVca5cIthpil47o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=i90cG9IhszT2yUnAIEn/VDyLv40vggHAA7JURwvB+0Bmqc/mhxHUAnuILLel96mRPKiacEojaOOVrCon9FM2MmNmWaSIcpqcjYWx/rJYTPF3/IRloPifPAGBnhn1Jcimd70Cq1+GW/3aF7L89dI+eCspKKCwxxH/p9VVwZ+PLfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SnpPGOiS; arc=fail smtp.client-ip=40.107.92.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SnpPGOiS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fl+si9sppzKrNUFyMEnsm9oMcchngj0U6K5pBDYSfJ6s2Wto/k2M7c8NBmXX1Dr16hcmCB0ZFZ/ctoQFX0CkG3qsl5wbChyz+AhR3ZdD1zjgQXPiW6SFeYDBt9ovH1j18WrFk486w201KwMmRHM/RT3OzOq0idyccyioFbaOodr9rs2KsQqgLeof8A0216NvNQXqmz4a9b8fgALUYg6TjMCiTDpNZGjlcof5w3TBf3FJVK/7y8CGNz/qMlC/BCyxrV5MyJRoupQpI9HnqiphLF1eFbJdfv7NJDg6wZy9G21/gBVYahdYYd0YYin7gzcU7C1KD+jr+w8GsG1N1nDgvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yr8iutMyTf97uKfiR8NCWgtEG+802gQZAYQ9c7aZuNo=;
 b=pCivQzqQhigAeMtI5TiK8h0HoBQDWQGRq9brMcyVt0emgoRCykdm0FhW10cdNyHq1d/Fpi7NQu+sjEW6jQiYVnu2iqbpJ57SLA+cwby21f2LtGwG7/IRCi/tXZ5ORQYTCPsHfhj9sPdnr2sJgg4AkpE14xyP0BDKUuDCCjRBVkr2+JCNpTzWvBGFDj+wURa2zD1Lb/oicYv8wMY1K64y5OkkNhf41/Irupu90yNYXT7JTZW1PH+NykHo/KdGXaUIJEDpVTaxAQDN0MLBe8h6O1qONPk9UbyVxrS6EUj6qSTPnsVVok2GJWz0A/J+XumgIpZH3K47Ul/+4Tc0Gl0uCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yr8iutMyTf97uKfiR8NCWgtEG+802gQZAYQ9c7aZuNo=;
 b=SnpPGOiSPA7WZQgo1halWQQkABgDGWHWJXi+nKGfa9dAVqKlbqQjbzKueGIlvJBqhbqYwwtpF6W1JDJGHFnstjBVGzCh/xJFYiVKuqnvV+KmZyERpArbj+AYVWQxxJCjVTGXzkSgUk3KCqGT6R3bxdbVrZR8+djYwvznLp7JjDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by PH8PR12MB7136.namprd12.prod.outlook.com (2603:10b6:510:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Thu, 6 Feb
 2025 10:50:15 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 10:50:15 +0000
Date: Thu, 6 Feb 2025 11:50:08 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 19/29] cxl/region: Use endpoint's HPA range to find
 the port's decoder
Message-ID: <Z6ST4HoCHAFo9WXt@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-20-rrichter@amd.com>
 <Z32oSTvQL8EmNmxz@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z32oSTvQL8EmNmxz@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|PH8PR12MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 259a6e09-6ca5-4ec2-0fe8-08dd469c09b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o9Sj38DAxTD+IfoxpeP70gG8sfwMbsMh3tEU8N75mgl7n7dNoSHkUNp0669d?=
 =?us-ascii?Q?hI7wfFFGgY52OVwLb+A7QQMwY+uFZemwyXijXH0wcruCUDKkAmnx59Sag/oE?=
 =?us-ascii?Q?6IdbMxxjPJrZiuqPGpb+yLMHiYBhTrj/X7UqXhsXr8cSddEz1+4ViD8GcMip?=
 =?us-ascii?Q?g3ptKqXCY/HrxfE4InLsdDCtHtkPln/dFH0zwkt8DIouGyCLevuxt4Yhgtvy?=
 =?us-ascii?Q?ZNWTbb3kUpbi06aBN8FhLCHedb3dzFGtpC3OpmXwzG1ho3bnTSD/BDym4XXu?=
 =?us-ascii?Q?/fUhEj4tvD28iOF8DXylqcl58L72tJoUicfqqdw2x4/IzbBDez+igstsOQgc?=
 =?us-ascii?Q?0EeXYZIhRnc8XlrPi+V2bxmlJiQZCLgoCuBWPL9weVj3xckBm06VFy8gw/tZ?=
 =?us-ascii?Q?yTnxuKCYrPMVlQED9fKIxmVJPchSGd8ztHJUbwuldTe0FoSx8Tb27QZsTTVz?=
 =?us-ascii?Q?bJg8wHo65zGFDxYOGDa41187KgcjTM3qlcJhmBIJNiQPCRFt9GYrIBYydJs0?=
 =?us-ascii?Q?SyCdVDkBVpAEMEBlmNynQkmb2nhz9+tRLCTV3Au2WgXiIB2+WR3HVIpPDIta?=
 =?us-ascii?Q?Q359CNLLV5DvCN9InHZ8WNLXGBJ4R5sVkMjH/CTbdsSHEiJURyMtfSPnnUbP?=
 =?us-ascii?Q?zPoQE830Lo5p8L9K3Qz0l2MH5O+sBjb+mmev9mG72Fw1j7A8CKjWmU1P3PvX?=
 =?us-ascii?Q?6Uk9HFB3BfjfglA/p2/oOL59jDjNHrwr5CEtjHlFh3YTCo9RbyfA38Azn8xy?=
 =?us-ascii?Q?tEdolFqSA6htjZAAcmxV3T47+MZss7hwDg19B9b/EMnI+VC6bquoE7VdLCKO?=
 =?us-ascii?Q?/6u9u0x7Pyayzjn0BU5mJCv5Ci4CHlcDRa9G3KxVctwpoSV8heXsnNx0aMN4?=
 =?us-ascii?Q?BwiHFZUyGv5yoMYK5ic7L2q5bA1VQqWk8g0uI72A4Jw2aewdbccbAyl5sjg2?=
 =?us-ascii?Q?aBWnDUPraGWVHSoDz/u8HszrMJSJORocQL6+FjWDU8/rw60QQOdztePk894I?=
 =?us-ascii?Q?ioEUnp75HAUKkCmNa08Grllf4xOwcMpIUH5DtZpYBcGdQrFef4WAhCJv+D8D?=
 =?us-ascii?Q?9ivxm78jfaSrZxnajDRlc8nKSnwE9DabHZ1eYXhiTTQH6BbYR8ITS42aI1Gk?=
 =?us-ascii?Q?QsUeEdfBY2zv5cXu48cyZ3QLCJXNITJOSWYQ9qxUm56tZ3LmmqtLcoqpLNMb?=
 =?us-ascii?Q?j37YPlr8dTqdSqSvMOwEn75f2erwQ9tiUxFCRIAIOylLeCZ8kerlLQlUjA0H?=
 =?us-ascii?Q?gssjhbkRpvvzQRmfoeKOTtkIW4h7RceASMfnXTn8cz694Yy7JRszQbaG3oxj?=
 =?us-ascii?Q?lSNJ7GXFpa3ROXiBAhRHptKkjASoVFnDY5436GKXOgDr7UlBCtmfax9CUTiC?=
 =?us-ascii?Q?iwTuYixHsXLrlOeloIqFXcDpMeRy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5jHnX+u0hPRCzJ7L5mTThH6O9mMUG8MejUv7cDdBiAUoMqfj/h8S1yhgSb4P?=
 =?us-ascii?Q?5e/0QdEXdri+fT0qOWY3L8J2rOhDKLtrw6aBT1yEcnCAA/Dv+igKF7b6CacJ?=
 =?us-ascii?Q?FQKvT1T4TlPU5j1TR/a+GRyLR3hwm4pA0BJh65s4xkvrdfd8JLxG2WygPa5/?=
 =?us-ascii?Q?1e59AjTOdm2bsY0OON5+xbkupqAVYH6XNdzfQGbL6Bdxu8UwBBecRpMMLTOT?=
 =?us-ascii?Q?IkODmViNe+CKvtmSYbHHyDszQx8PuAge/wumePVxnbGQy4Vz3SHfV7Nx3n3f?=
 =?us-ascii?Q?1ltPVAtFda78vxRVzzoa4+6WOFCpUEuZKAF1dJyoLdraRvroVZS5NrYLzRFF?=
 =?us-ascii?Q?vk+g93Jd75IdlCz8wnOYW6uazvF0fRz/91uQOOUSA4LM+TNGIzt9KHxlijX+?=
 =?us-ascii?Q?y2XnOFD5hfJnt+q0DAckRdkKoiGAHD2x62KQ3A7ID2oUmcoUbs2Un/vhzGfx?=
 =?us-ascii?Q?yMZMbfWe5ZyfHBiPFUy04pzK8NiTenzJtL5/HzpIsvQfgoN9JGzOvQjU2ST/?=
 =?us-ascii?Q?17uvG3gaiLtbmXEPP6XNkpU0gPex7E/G65kt6A76hTC3k+9LlLtRUi7YUgME?=
 =?us-ascii?Q?VPWfmkMykjPv0px/spZmjOh3Km3kBK4zzamCFsy7lFWsg/G4UO8ivgeZm9mx?=
 =?us-ascii?Q?jSMn61KzyR96gAEmkLfMdGavuZklm6kmdW0OPlciIdXWYwuJ0qe4XJik/Ifs?=
 =?us-ascii?Q?4eCYzeyv2z0YHo5mx+8i+MhykenYkoaD7sk4YJUQJNVeeZf3lwMxAY9rsl6e?=
 =?us-ascii?Q?qYAjZM3kGOzb11VX6RnAZw7h5Rb/uZfqfCapSrpUgUObsGbsXTY2sOqkwAQ8?=
 =?us-ascii?Q?O/Np9yW2JpC65S6AW3ePsTumImSKtXkt0Mg0w/h4EdDwY3mY8g2yovjwmhjU?=
 =?us-ascii?Q?yZD+pGoKk8YWdZFGrQJA0s0r9K8hrsqq6rYeJCNqeA6nkCRDaBOR9tegOqhC?=
 =?us-ascii?Q?t3t5VN70fQRV8fHyZmOKFznb95VtVLBH+x2KyaOPQ7VGjXj74qqOxD39pyUX?=
 =?us-ascii?Q?pchPH4ocJ4DQgbfaF2lCoBqC4tMLTzL6KTyTXRa52rQaCoQCxZsliCBQC0vH?=
 =?us-ascii?Q?MvA30hf6dcgwtkHIGkV6cNzKkwvxgBO5YHKxg/VIoZQ1P6i3b3wRn+4jgN+v?=
 =?us-ascii?Q?Am0vx8WlSsmmzhhOuO5Gy+QHl+MaJH7MW+naruBVHLaJig6HXMOQAP+fhFwN?=
 =?us-ascii?Q?b29ZN/SXg7fwJIjujU3XZNzqCWNM2nndXTwZqm0shDrjK2N9WLcyDhm1mSbz?=
 =?us-ascii?Q?aHHZg3AdLR8bogXRlRp01VUcOY1wU1FHaSNhC9W03Zs1U07e6TOOq3ZRGtD4?=
 =?us-ascii?Q?kD0qkpw1qfaM1F9K1n+Cf4Tesrpa6tCBeTmPOY2MKjdbwi0IduuGyCAgRuAj?=
 =?us-ascii?Q?wp+d8uW4UI3QO8SUV2Mwg+TRycUZAfrmSd/ZO9EkUcGYz5Ys2BUfqDR0RrRm?=
 =?us-ascii?Q?4gsydWH6x2Iw4xwwbCPXBGmeTvkvUW/HnlAZXtu+Gw/eBB6APeo/O7RGK29r?=
 =?us-ascii?Q?sTAhwYXgTbwIRJTFuKX6//kaJfeBdDBR/4zNMUSJg2bCPFVE/kNEcacAG3N1?=
 =?us-ascii?Q?646v4NJ7uf8T53PlFvS9hz+dgyDaPx8wa+l/W3zf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259a6e09-6ca5-4ec2-0fe8-08dd469c09b0
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 10:50:15.0037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wFdIxnn5jk/QY0oz2OFtsNuipMh6MLwnZqoji+f/D+4qPtu461E18ddDemZo5q5ueEILcr39t0cv80kG5G7qQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7136

On 07.01.25 17:18:49, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 03:10:05PM +0100, Robert Richter wrote:
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
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> I'll make a note to test up to this patch in particular in HPA==SPA
> mode without the follow ons.
> 
> The functional change here is the move from cxlr->params to
> cxled->cxld.hpa_range. 
> 
> What was the likely value of cxlr->params previously? Undefined?

The region's hpa range was set up with the same values. Thus it can be
used interchangeable.

Call chain:

cxl_endpoint_decoder_add
  hpa = &cxled->cxld.hpa_range;
  cxl_find_region_by_range(..., hpa);
    match_region_by_range(..., hpa);
  construct_region
    hpa = &cxled->cxld.hpa_range;
    *res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa), ...)
  attach_target
    cxl_region_attach
      cxl_region_attach_position
        cxl_port_attach_region
          cxl_find_decoder_early
            hpa = &cxled->cxld.hpa_range
            match_auto_decoder(..., hpa)

Note I have moved out the switch to spa_range of "[PATCH v1 15/29]
cxl/region: Use an endpoint's SPA range to find a region" to a later
patch for a better understanding of the changes, but technically it is
the same as there is still spa == hpa at this point.

> 
> Otherwise I don't immediately see any issues.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>

Thanks,

-Robert
