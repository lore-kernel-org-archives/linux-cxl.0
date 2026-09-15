Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010004.outbound.protection.outlook.com [52.101.193.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CF3D7D70;
	Tue, 15 Sep 2026 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459902; cv=fail; b=TpefwUPr0VXlBLHCa1EOMiTleglkn1I/bxExjhqKZgGvyfEQn45f3DqDs4CRReJI9sr+nGT9QutElq+tXuTB+t54iPaJkrdrJ/RoL7ielSngAuBJJUPvCa+jaKnAAJvZRJ2nhqRjofMqSDYaJrnluB+Y99lfneY43tuDy2vTf2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459902; c=relaxed/simple;
	bh=Gkp7ZywezucSaIM6fcsuvwjIaS8keNEUfgs5btQV1dc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=goj3fkwHaoz9NAPjZYZFo4T5uUS3lIL7P2cvsnByD1UrQaA4hv9ps0noG52F0gX4YwK6RJGG65KU5eF1nmurXL5yIzs5FSq0ZhMFu7znDnUdDMv507aqb5yXPAj1PIeZFt2WwJRCPQQONRszLZEQ2ZKLlFp4HKpZDog9HM5NR8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tpw8onTh; arc=fail smtp.client-ip=52.101.193.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tpw8onTh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6Kg/uzOm8dSc+BbX/FKmzb0f07V0wdIDZL/FvhZOvCSNbTnP4IBGVWkhyZuX+oOtDuoHL25Ou+btHKxi/wQsU6mNyGHsTNXhvqKLHP2uu9QC876MwYzqUSr5UifbtzW9KoXvnpuo3TveL8br/qxl+zMi5BJQAE8XS350x5LQbWmcjf3Zd7EQyvF79qGCZoOszzsQx4UHxfglQ+EKfIY0iVVWMcWTGqGpBoWpQYSwJ/rfZM08jgdrrt5ZFZU8xE/ApFHbPAvAhBXuNRZ98CZrU4GPvBxfw0GF9DhRl1nN/R3WG0wAvIw4aA4fIp8y8usG/yG0USrnw+1sHYzX8L3JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0v00KkXa7uy8U7g8gDZtss6JSLtmKrKqZIMUrP2pAVs=;
 b=vVGAKOLjieiHlf/yhJEKDWUOgWKBSdDlhwi+wTzWr43oi4Go2AAFS2JKPdvqoQ0prhX4gieK0KNoltzpRzqpvcRGm1y+25N/NQIv1UHn7/LQNcHsJVb0fkPIBa/j0WF0H+9ATG7TNkFWh+BKAJQRz+ExfuwuWApB/GigNp78vooPPNELTEfi4cbEDvzoM8h3uOnrR25FIaljcE1Vy6397NlwnPE+BX1aAVmu0zzO4hOMu9B4qv9x9XLMCLh7AXR77tsXCslTw1moLBu9x40p5dU2vILzWPLgbHwsM5tQBfxeQL4a1mEmplnTW6UkDxnSfq6Ip+8KMCED0N1LT693Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0v00KkXa7uy8U7g8gDZtss6JSLtmKrKqZIMUrP2pAVs=;
 b=tpw8onThVHQ6vaEBKvkRR8vOQWorXCs47kZ9KiIFVTF3tjfEWk7B+y6ccAiPtwu/Un86TYmMigAw0Nmm0Py8ukZ5au0/T5Bg3h0KFkfyJvXkYwh3ox/5l+b+kTwXZVWkTigLuc20sFhha+bJ8b4OhuUpSH0yXt6fAoMaMnLK11k2uYe9/S3B1YPNd4P/qgrvPeARPbDDfFiRu+ZFBKCuscaujb5Q2iU/jv1cjY+NOxBsuUJ3BTuVQnd7o1qF3bB74orh/Wv2mGbDklqK3cNG02NkONL6UGrQjTU+iBlAgMmyAKyvaGPh2MKcqFhCo68XY+hSt97gxW8O8XUseJfXrQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB8230.namprd12.prod.outlook.com (2603:10b6:8:ed::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.9; Tue, 15 Sep 2026 08:11:34 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 08:11:34 +0000
Date: Tue, 15 Sep 2026 16:11:27 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	vishal.l.verma@intel.com, iweiny@kernel.org, ming.li@zohomail.com, gourry@gourry.net, 
	rrichter@amd.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kees@kernel.org, newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, 
	kobak@nvidia.com
Subject: Re: [PATCH v7 0/7] cxl: Sashiko bug fixes
Message-ID: <aqj7mRx4EcO6K6oz@MWDK4CY14F>
References: <20260902053839.25595-1-icheng@nvidia.com>
 <appVB-P7pFRdwjAX@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <appVB-P7pFRdwjAX@aschofie-mobl2.lan>
X-ClientProxiedBy: SI1PR02CA0012.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::8) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB8230:EE_
X-MS-Office365-Filtering-Correlation-Id: 1615ed3b-dc9f-4561-fffb-08df1300f50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|4143699003|10067099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	YSDPwy3rKF9gvvOih7JlJO87UaLBwxKmH7wNeI8qUsR1jcvdwzHSWrpJa5bNG0PygYVg0G85YwqKcR5UXw6NgzqWJfCWw++6DATUmx7wzbXN9uy4R5Wfx/7F5aLAJc/MjqtKE4sWeqIBkH9nwSRPNeFiouBfSEjB/eCANWXC/WCMb/m37x+5gZix69gWP6DvzylxTgwoVjisDJ8GJ8To5DbyAkzHeCIR0FR8r/HIlSmN23iC6GZUq5xlzFYz+DaMKlJbinCFf7tQyOgeUKEDdFqJ5J12nzD5mC9viboAhbC7lJioZoBCtmzWvT8rHJrrDv9s3zg3yFKHyyWoNc/+UuqmivGoXRVDhTOY/piErDGDObwVZxuieCGA2SjFD5EBW2U0KFXoJ5QYZShCfG4IZgzuzvHC5DhCGMPLWlSLyBUPfyzskUQKnpdC45t7f6sHl8SmJAe8Onu1vTLq8GXY5GVMS5Os2han0Uh7b9Um5QZ9XTyhqaZi7dAVwQA0xqKK14LJ/HAq7ejMmdjBukcVgAhsoPgwOW58NCD2OWzmR7HG2QVnAZZ1u0t6tSHQr5fGKaz7crS3K2X6c3XS212VZbE80G+aBvwc1g195pxUd484hBno+xqwqg+hIX0FM09fvXRTY5m5Z9ncv6DodP/6HLPKFcaiAkuM5WBmW0zdi5M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(4143699003)(10067099003)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Zyat3yYWywNTtk3aRJwgiM8Idx/tOl5mlxLtU2Dcb+wFduV2mC1g3E+pOw3x?=
 =?us-ascii?Q?0KCVM4Zim8FiqzZKgsSsiy0GpCbpedNQh0Q2HRiBi+kZ8Lf2D4mr3ysIikyU?=
 =?us-ascii?Q?vAAYxVJxV0OtEGw7rNbeC0P31Gt6Pl69ZzVzv+GXkw8Xzg0ifC1gM9cJFWtD?=
 =?us-ascii?Q?ZefoQBSpkWaSbu1UM4RrsCxpnFEJrgbjc8xF2+Rzeoy5myBtwSlez/VGyMaZ?=
 =?us-ascii?Q?sSDwROcTxf4OD6EZ/ShcjI3maHKWhNPQFcTErniGOYNPxx7kWdRJHGWY4B+i?=
 =?us-ascii?Q?5iHTPCut2ifVy8CUqYg5jOexYNL/OYif3xmC33C0HQMhuoQau3xcvbMxSTlm?=
 =?us-ascii?Q?VBVudsN8PpykL024UWMazFIT1QM0SS4f1ly9evY/UDApbhA0amPiYBQ0X3GC?=
 =?us-ascii?Q?wTrm1o4j51G3inMDzvb4WfsOhqSeGLDbY4wG00HD5KoZOBYqaY4h1GmoMGeq?=
 =?us-ascii?Q?VVISFJmkMlgJnwz2+3Zf8SmClF21Gd7JGu3tOhlP5uIAOsQloMLFFLW5LTvd?=
 =?us-ascii?Q?xGSmhujGSHCEnIyPcyVVhojGBtkqqgCWr2wQ4iF8z8GhX+KEwGd1mVIqWxBH?=
 =?us-ascii?Q?MCuBl3Lz/HmEVkC1IrZ2kAKDLDWXvq9ARZwS8J02hNE4LX2dy7Z0E90fcCWP?=
 =?us-ascii?Q?lAheYG3nNsGVia2Qq7OcytM9m7qcq5zeVs662n4cN9rl9ewAr0Yn7oQo3AOw?=
 =?us-ascii?Q?Senyyx0zsnELuU04JQt8Rm8vZy/qEqRoFyI3y8Jnp1e7by6+dE29KkhxhRG4?=
 =?us-ascii?Q?sRDR7bgIzx97Dk4Gx7foCtsvDt7t1TfGELtfihnE880Sn245jQPj0lZN5yR+?=
 =?us-ascii?Q?KCgsMts/pcSvVDTjXEjkdiKjjGhSKdbUqz5kvdwxd+XTqsHJWGLJ/df1ZMBN?=
 =?us-ascii?Q?FuvPes5gtSyVX3qHwu/9VC6Y3BFfWCCt63Uwqrex1U3ZIsHgzlsURfNpdoRB?=
 =?us-ascii?Q?+8odlX0UviYtw5GDV1MDTqaqEhDmYVpNsn6yVXv2F4yoH6wRPJAlS6s0lloe?=
 =?us-ascii?Q?xEHs2g+TZng1EjwYRSfS4EV04t2sTApgO2u/eD5eRIwRuA2dJQrVVqq3RUo5?=
 =?us-ascii?Q?R8WajahNGb6n8D3+mhc+q72m6uIBJf/Nl+UA3K/z/wM0joRqYOxY8mILNsov?=
 =?us-ascii?Q?hm4V+cqLQtsq2L0JSz2is9Ifa3hbyYwPm74ifF/i9AR/E7PbfiQzz56dDAau?=
 =?us-ascii?Q?o+NFxfrtcwjQY3FIoNLWAEc0wVweoURmlIJR1BGKBKOiBn2WzHYgK1h+I+8S?=
 =?us-ascii?Q?9/WJFb/TPqChW9+IzMCdOMiJ8dAVnkNdG6fYAWBM20xURAdhQpr8tF42TM70?=
 =?us-ascii?Q?yCaiuXXbBYIw6Rxbax23U0iO3g4V3CGZoEbsKOD5G4F8hVvWNouCJqrvPrsD?=
 =?us-ascii?Q?iILOmWLCuYZvsyL5sBpofZWfYmpAvwBm76DKOHkzXPaVpawM1+EUDDKNFpas?=
 =?us-ascii?Q?BIThrQG47KbMiPg3FzRvPoH18cwh0BYNAZOjY2t1uXR0nAAuXDEA4Nx5B4uF?=
 =?us-ascii?Q?LEHUNa1fwLun3OhIbi3bApLHk3hXxdOS8g0/kNR9xSsPZy+/DDi6qSRs5xXZ?=
 =?us-ascii?Q?wEijLZ3vYM+1acYD1R/2WIQeoWS4RNTxgclyti3mktgzjjf2cDOcfHCktovF?=
 =?us-ascii?Q?6MYyfNYIF6jZt12ujvClthmxbbp0dQDdIoaOeMKmO4ZhpimK/u/7HZ+eLMKZ?=
 =?us-ascii?Q?R13pkDR4PP7E0dFk9WlP9stB6rRQenjrlKmBHGMGJ3Px86Gf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1615ed3b-dc9f-4561-fffb-08df1300f50f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 08:11:34.6537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7t4Hs3Wceq+g3Bfv0svhhBkA9sekooklrCgiA8BGg+CKiTyUTqVolvTJPuinZTh7Zofkn76Yj73eo7Eo0envUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8230

On Thu, Sep 03, 2026 at 10:20:07PM +0800, Alison Schofield wrote:
> On Wed, Sep 02, 2026 at 01:38:32PM +0800, Richard Cheng wrote:
> > Seven independent, pre-existing bugs in the CXL core, reported by
> > sashiko.
> 
> Hi Richard,
> 
> I finally got around to looking into all this poisonous code ;)
> because I had an inkling that they couldn't be independent nor
> coincidence based on that common Fixes Tag. That actually is
> the issue, aka the finding.
> 
> be5cbd084027 is described as an enum removal. Mostly it did that,
> CXL_DECODER_PMEM became CXL_PARTMODE_PMEM and nothing else moves. 
> But three functions were not renames, they were rewritten.
> 
>   cxl_get_poison_by_memdev()	two if blocks became one loop
>   cxl_get_poison_unmapped()	rewritten, no line survives
>   poison_by_decoder()		gained an unguarded part[] index
> 
> If you line up your patches against the pre-rewrite code you'll see
> that each one is putting back a statement the rewrite dropped:
> 
>   patch 2   'if (!length) return 0' was correct because pmem was the
>             last partition.  It became a mid-loop break.
>   patch 3   the RAM branch cleared rc on a tolerated -EFAULT.  The
>             rewrite continues without clearing it.
>   patch 4   the function consumed ctx->offset.  The rewrite derives
>             the resume point from the resource child list instead --
>             note poison_by_decoder() still computes ctx->offset and
>             nothing reads it.  That dead store is the tell.
>   patch 5   'if (rc) return rc' lived inside the pmem if block.  When
>             the two blocks were merged into a loop it went with the
>             block and was never re-added.
>   patch 6   be5cbd084027 added six new cxlds->part[cxled->part]
>             dereferences and guarded five of them against part < 0.
>             In cxl_region_attach() it reordered the existing checks to
>             get the guard ahead of the index.  poison_by_decoder() is
>             the one site it missed.
> 
> BTW - I did confirm it was not a merge issue.
> 
> Here's what I'm thinking. DaveJ can pluck patch 1 and 7 separately and
> you can take another pass at this as a 'Poison Repair Set'. 
> 
> I walked cxl_get_poison_unmapped() against the pre-be5cbd084027 form, but
> not the other 2 rewritten functions. It would be good if you can do that.
> so we can be sure nothing else is missing. Doing that, along with
> addressing Sashiko citings, will get us to the finish line on this one.
> 
> I'm going to reply inline to Patches 5 and 6, but here is the
> highlights:
> 
> - Patches 2, 3 and 4 together restore cxl_get_poison_unmapped()
>   and improve upon it. It is partition-generic now and no longer issues
>   a zero-length Get Poison List. 
> 
> - Patch 5 fixes the masked error but loses the poison records that the
>   pre-rewrite code collected before it reported the failure.
> 
> - Patch 6 fixes the out-of-bounds read by failing the whole scan for
>   the memdev, where the pre-rewrite code scanned that decoder and
>   carried on.
> 
> -- Alison
>

Hi Alison,

Thanks a lot for your detailed reviewed.

I have a few questions to discuss with you before I sent another patch series
for poison rework.

So for patch 5's issue, if we get RAM query error and PMEM query error at the same
time, which return value would you prefer ? I think retained all the record in
some data structure wouldn't be an issue, just the return error, you would like to see
the first error or the last ?

and for patch 6, I see it and will addressed it in the new series.

Best regards,
Richard Cheng.
 
> > 
> > Patch 1: Get/Set Feature derive each mailbox command's offset from the
> > starting offset plus the amount of data already transferred, then store
> > it in a 16-bit field. A large offset/count supplied through fwctl can
> > cause a later offset to exceed the representable feature extent and be
> > truncated by cpu_to_le16(), targeting the wrong feature data. Reject
> > invalid ranges up front.
> > 
> > Change cxl_get_feature() to return ssize_t so invalid input and mailbox
> > failures are reported as negative errno instead of being conflated with
> > a zero-byte result. Update all EDAC callers for the signed return
> > contract while preserving the existing fwctl RPC response behavior.
> > 
> > Patch 2: cxl_get_poison_unmapped() aborted its whole partition sweep on
> > the first fully-mapped partition, silently skipping unmapped poison in
> > all later partitions. Skip that partition instead.
> > 
> > Patch 3: the same function tolerated the -EFAULT a RAM partition returns
> > for Get Poison List but left it in rc, so a benign fault on the last
> > scanned partition surfaced as a spurious read failure. Clear rc, as
> > poison_by_decoder() already does.
> > 
> > Patch 4: the same function also ignored the ctx->offset handoff from
> > poison_by_decoder() and derived its scan start from the highest DPA
> > allocation, so the DPA of allocated-but-uncommitted decoders was never
> > scanned by either phase. Resume the sweep at ctx->offset.
> > 
> > Patch 5: cxl_get_poison_by_memdev() overwrote rc on each partition
> > query, so an earlier partition's failure was masked by a later success
> > and unscanned poison was reported as a clean list. Stop on any error
> > not tolerated as a RAM -EFAULT.
> > 
> > Patch 6: poison_by_decoder() assumed every decoder with a DPA reservation
> > was assigned to a partition. Malformed device DPA metadata can leave
> > dpa_res set while part remains -1, causing a poison scan to access
> > before the partition array. Reject such decoders before the lookup.
> > 
> > Patch 7: the Get and Set Feature fwctl handlers converted all helper
> > failures into normal RPC responses, sometimes with a SUCCESS device
> > status. Propagate delivery failures as ioctl errors while continuing to
> > report actual device errors through rpc_out->retval.
> > 
> > A nonzero short Get Feature response is valid when Offset + Count runs
> > past the end of the feature. Preserve the returned bytes as a successful
> > partial transfer, reject unexpected zero-length success responses, and
> > require fixed-format EDAC callers to receive their complete attribute
> > structures before consuming them.
> > 
> > Changes since v6 [1]:
> > - Patch 7: Remove redundant braces. (Dave Jiang)
> > 
> > [1]:
> > https://lore.kernel.org/linux-cxl/20260826014508.9989-1-icheng@nvidia.com/
> > 
> > 
> > Richard Cheng (7):
> >   cxl/features: Reject feature offset that overflows 16-bit field
> >   cxl/region: Scan all partitions for unmapped poison
> >   cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
> >   cxl/region: Start unmapped poison scan at the committed decoder
> >     boundary
> >   cxl/memdev: Don't overwrite the error from an earlier partition poison
> >     query
> >   cxl/region: Reject poison scan for decoder without a partition
> >   cxl/fwctl: Propagate feature RPC delivery errors
> > 
> >  drivers/cxl/core/core.h     |  8 +++---
> >  drivers/cxl/core/edac.c     | 30 +++++++++++++-------
> >  drivers/cxl/core/features.c | 56 ++++++++++++++++++++++++-------------
> >  drivers/cxl/core/memdev.c   |  2 ++
> >  drivers/cxl/core/region.c   | 15 +++++-----
> >  5 files changed, 71 insertions(+), 40 deletions(-)
> > 
> > 
> > base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
> > -- 
> > 2.53.0
> > 
