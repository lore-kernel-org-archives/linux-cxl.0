Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2099.outbound.protection.outlook.com [40.107.93.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C38131BC0
	for <linux-cxl@vger.kernel.org>; Tue, 16 Apr 2024 17:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713287753; cv=fail; b=sqbynqbPyWRKfOtOhY1BmfTj1tEa4dVKn3y9Y0+lflEia8oZpqD6Vr5LxfW6Nyx0rvzfNfvLbobbFYPje2BCt3gpozG6SKnOcEQVSsJCqob06nGczfoC9/4xHmoOrNIcHw4t2BAdUd0rZ+/d+08TBhqAPKDANJBtuLxB9GNg6x8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713287753; c=relaxed/simple;
	bh=pOewZFnp8a3SlACr8pmMa1QVj9P0tflygi0wuP0wyZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JBvx/LP58bBAEgwK8yApWwW+OAFZjZ8KXMxlHsYD0yzMr0zcLvncZjG7IoZxWIg2rsb3bGbzPMmFQX4MAl4MyIZS6SUrbo/ztLCxAfSUADPuNe/WHJFEYvOMTlOBmogjs7frU63BbnhiimCSnNtszPVa6InoNCUPGSmDx/l2NnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=du8ajFkl; arc=fail smtp.client-ip=40.107.93.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="du8ajFkl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HuT3y/UbleQiUIvqCgHA8MS1p6iptjYPEiaxrFoqQ4QuJJAPHR6r+6F0t8eaL03D0xwrqpY75o91Bz/4OPoU7xG4QLlaX2Toe4J0etwo5NToWCrqGJMvBaL95sCK23qaFpdb74ck4u7KE4kJ00pjDS58SE2mHKSsFB/qypG9x9mmXbfja/3M3q95Kv9/aXvQUnR7WVPY+Idh8xu6ag/ZYUBD2Nj0LGt8KeBtmahX94THlUs480L4VPz7XV4odklzhPqdLsoiOjcHkWnzqxByC6ZAvqPbApYso9Ax/rtgCcCLEUoziO+Ru8Q4wAPFXYn8qySz3k/XmoCcclkpmd7wWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dYWF4ZNL035o0lPcryp3L78l7KmeFmCRvi0DstKzmu4=;
 b=dxKzNAU9Ke8pcBJ19k9vxTpn+6xnY0GZjXhPs4N90IORI4I2lai5YLji/RzMxYVd91VbQY+4pCqoD6dyvuPovRmuHahKEtKDbFNvMlWqBgUkIkrxsRc76n2Wwg+JW0FzG+JJB7QWidFAKVDUA5497ZbXfcaVdUzXFRKGF7b958MWMbFTQ7hO+UHxfAzTWx7K+fCe82x+32dvjECLUGKLFny/AMHqTAl2KzSIj51z1Auju14NmKciQXb/uHjONzZuAz1KdNdKd6Z93gH2BWsUUoFvoQItfwQyyHAFsg9FiOuOU1agEW8uvNrMIm1338lBVKtt79z+0O8da8ZRcTsLXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYWF4ZNL035o0lPcryp3L78l7KmeFmCRvi0DstKzmu4=;
 b=du8ajFklrnSdBukw0OrO2Wourgyckx8ks5UfhwZkFSO4tq+rzQkVuk37usU60HVCPpchfqax2Dzl46lIqBF2XaYGxjDSpzBmlONAyOUPisgxgZWMGOvAHTChhWYFTnRSIrqFvsHlOjGHK3JZxFlHMRVN/3tULP2WaYEVqESW/n0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA1PR17MB5459.namprd17.prod.outlook.com (2603:10b6:806:1c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 17:15:49 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%4]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 17:15:48 +0000
Date: Tue, 16 Apr 2024 13:15:44 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org, ira.weiny@intel.com,
	dan.j.williams@intel.com, a.manzanares@samsung.com,
	dave@stgolabs.net, nmtadam.samsung@gmail.com,
	jim.harris@samsung.com, Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 10/12] hw/mem/cxl_type3: Add dpa range validation for
 accesses to DC regions
Message-ID: <Zh6yQPIsNm44OJyi@memverge.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-11-nifan.cxl@gmail.com>
 <Zhm7ssKVGdGlR9Iq@memverge.com>
 <Zh1lk8FWmf0oI7RM@debian>
 <20240416160056.0000325c@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416160056.0000325c@Huawei.com>
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA1PR17MB5459:EE_
X-MS-Office365-Filtering-Correlation-Id: 2379e9f3-ead5-462b-7628-08dc5e38dc16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q4XXbM7O479mwbEP6mCz81qR/CvZ/KZEXjMkREsW9f5//YXYbbEz35BM3QAjepKslp7N7YjtSOoHF3jO372mDSJMwG8Rm9p66XKbjkb1rzRZdF46MeP8CXWXcq6D5lcN5HIhr1ZIiwp+6fgW+tezMukHJmNxPiPmVUXslyoAVFQnI6+m5u6Hwt6kbILLWfi68igwaUZcxOIwMOja1iSyVNm1RHm4yyjvcOZP4W1DUX+S2gRPe2GnvSrGl2filHypIKYkYm/CE0PLgZ3StU9o8b6K2E1ImWLrhOCoDmXbvMcjmKzd4SwHUqof5LovHMNb0CP8D+b1N7mDvkqkTKDBkGUU0n3d8UaUP+e/O+MuRujQY9wFCU+Na6CwO9eNkOci0YGfhVbc4hW6nXnk3sQheLnkQDH6aqzk24jhNbBKOT5SKgFyZEL5PUwcg9WO1wWqxjh0vPm2J32hIBXfIUWRot3hFb4ngHKp0wI5RD3gNYqBDrzV4G1z2KIFiSbsRt6FY8Id2UQTbQPOAo1ALwqmz5WLp3fdXp+vLOETU06FgGfqLVDKDp21GYHiPubskazzgU4TH0QINk4Yrg+S9jX7VNFV0/SAgXO2XR2JaZPStI/r651YVNju2OeHKYMPCBespzIQ1gXD2ZXN8jyA/0aIYDob29DZtK8lUAdtEP5gWr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HoRx1lVqcL2VRyV5c4+gIL0J2sEM8hq69+VwgOH1pv7JAYZCVs7KrelHTP9B?=
 =?us-ascii?Q?NDPTyJBKVikoW7iGhYbfSFQCJSv8SgR8UhDT96hmhGFTRkKbrXurAgFbcx/8?=
 =?us-ascii?Q?BADH+hl31nHAff+buytuywyIhtIpvwcjl3iTajUd3TL2i9gLBNKhuwmsomqr?=
 =?us-ascii?Q?G37b4YBUuQwMfFNBBw5npC7qYQawDkihAZUx2uYLOTu1Nj++eIB4Vbdnx4iI?=
 =?us-ascii?Q?2yd0OjgbYghTX6ccrCbHmSvI3VKZaYOcMwOU/4ogcqwmikmLg/FHpBaP+gVT?=
 =?us-ascii?Q?ljFanA+Ha89mAAfociuqfFNjajhABzNjOJrvm0I2/iRJnK9qtN2wM4mty7fZ?=
 =?us-ascii?Q?BVgNCxyhAjHN12aLbHmF+CdW2AUI7tX15WD3c4KjVBEg3cP2wUH84DqAdNYW?=
 =?us-ascii?Q?RN1lHvQGPGbeWQjti1FYyCoBTn6j2qJixELWQcLzORDI1HaWNZJgBXFlFITL?=
 =?us-ascii?Q?ztoRnjJyFQ93RY8c1ZjdaDp9qG0xBMTbk4YaUdcjV10Dfq70jP0xUfpLQc/V?=
 =?us-ascii?Q?dDr6lzQ6I+OC0u+1yDGHxZ/nd17A1sfqGYg8eu6HNQuicPvG9LPUifZzIWzD?=
 =?us-ascii?Q?3ONgEuAWpdb77+Abgh7jXiTfo2Tn1E4ErQJlKoXNSXa1DHmfk15wmdU7E5Hd?=
 =?us-ascii?Q?PcV1KKeQC7RRQtt2ZA9PfLT8BfVrmkZ3pyvpQ1FDCeYtyMMdRgC4J9r2gXrA?=
 =?us-ascii?Q?esUuQ7UrioL0QoYkQcIx5L8pP7N+vtfplpEmW2BVyBws6jPG9EAtR8H2IliK?=
 =?us-ascii?Q?BLeJ3SgzJVg1klSMfDjYYLd67HDlHNYy+fZfqFJ4N9iv9kP7Z4D/IdLncXVG?=
 =?us-ascii?Q?DlUZPqmTiNb2O/eASJnPQEDI8wYr9bqn2INJUIGf4v0obm/c5/g1XlrWp8Nu?=
 =?us-ascii?Q?pyJWS3y6b/f3iJ1obAGIBIXMzeU38z6ee4pkA6tEZ8+Pu5Hnxj/tcOwq7zSQ?=
 =?us-ascii?Q?yvcS5vMCtXdwrakQ2wVOMCQU7op3m2Dy+j6e+9syAtn2yJ6T6KGZKTRSO7Is?=
 =?us-ascii?Q?aM992AR+GFC+5WRVvVvT26WfKtwajM6mc4YHOzM81rit6AXER1RKhkC3b1ew?=
 =?us-ascii?Q?LCN0MqmA3ECWKI2bSIfZLMwoz9hgLdeNyjEHdK3mi2L/0XwftmkScvyUC1Ci?=
 =?us-ascii?Q?Fj9GjY6C07mvwXN2bp3OXuNQUFU/a44pSaYUojWHsnm/U3SQv8F8kQ/TWP/K?=
 =?us-ascii?Q?7rs0+MqXBWIyoKLjlFrDmqlgICj8YNBciOEw5R38a7dOWQEWsIDn+KN/k6hQ?=
 =?us-ascii?Q?PZuIzslrpU85Us853OkrbJy89S6D16CQ987uoWB/uK5lhnNxljg10xoFv1G9?=
 =?us-ascii?Q?FjbK4BwFo2J3NLa3M9cpQCAUH+JHubZUBHm7XZ522L2dYbvMcNrPUaDHTHJN?=
 =?us-ascii?Q?PoTbnZrt5izs3JV7mvekQNDicDkz65JTJCcjBW4tbVp6uk8bSbl/AOvrQwBp?=
 =?us-ascii?Q?It8V6qdiE3FlgZzM80wNH2AmzCKeFhrEHqCbS7w2qSs8iPzXHBV/POfnKK7G?=
 =?us-ascii?Q?S/uaM4NbHM63y7yw0UlTZmtJq7EoFxS1zG9QOIVclj+vE1NPGUi3/zF0Yrcu?=
 =?us-ascii?Q?AP3Q+PCW/ArvQia6ULy6KpK3juIjCypOuTbZ/844PajpsacJZq7LdurNYa2k?=
 =?us-ascii?Q?1A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2379e9f3-ead5-462b-7628-08dc5e38dc16
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 17:15:48.5000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLx31i3em8W2mL1UpfmT2yzD7QSoM/+7ektmXmVWcUFz3E0+g5Z4JyGKM4XOfgn5HcqD0Vt2Nx/ye5LB/3Z50FFvsECIc/Z6q32Ox6PoYDk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5459

On Tue, Apr 16, 2024 at 04:00:56PM +0100, Jonathan Cameron wrote:
> On Mon, 15 Apr 2024 10:37:00 -0700
> fan <nifan.cxl@gmail.com> wrote:
> 
> > On Fri, Apr 12, 2024 at 06:54:42PM -0400, Gregory Price wrote:
> > > On Mon, Mar 25, 2024 at 12:02:28PM -0700, nifan.cxl@gmail.com wrote:  
> > > > From: Fan Ni <fan.ni@samsung.com>
> > > > 
> > > > All dpa ranges in the DC regions are invalid to access until an extent
> > > > covering the range has been added. Add a bitmap for each region to
> > > > record whether a DC block in the region has been backed by DC extent.
> > > > For the bitmap, a bit in the bitmap represents a DC block. When a DC
> > > > extent is added, all the bits of the blocks in the extent will be set,
> > > > which will be cleared when the extent is released.
> > > > 
> > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > > > ---
> > > >  hw/cxl/cxl-mailbox-utils.c  |  6 +++
> > > >  hw/mem/cxl_type3.c          | 76 +++++++++++++++++++++++++++++++++++++
> > > >  include/hw/cxl/cxl_device.h |  7 ++++
> > > >  3 files changed, 89 insertions(+)
> > > > 
> > > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > > index 7094e007b9..a0d2239176 100644
> > > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > > +++ b/hw/cxl/cxl-mailbox-utils.c
> > > > @@ -1620,6 +1620,7 @@ static CXLRetCode cmd_dcd_add_dyn_cap_rsp(const struct cxl_cmd *cmd,
> > > >  
> > > >          cxl_insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
> > > >          ct3d->dc.total_extent_count += 1;
> > > > +        ct3_set_region_block_backed(ct3d, dpa, len);
> > > >  
> > > >          ent = QTAILQ_FIRST(&ct3d->dc.extents_pending);
> > > >          cxl_remove_extent_from_extent_list(&ct3d->dc.extents_pending, ent);  
> > > 
> > > while looking at the MHD code, we had decided to "reserve" the blocks in
> > > the bitmap in the call to `qmp_cxl_process_dynamic_capacity` in order to
> > > prevent a potential double-allocation (basically we need to sanity check
> > > that two hosts aren't reserving the region PRIOR to the host being
> > > notified).
> > > 
> > > I did not see any checks in the `qmp_cxl_process_dynamic_capacity` path
> > > to prevent pending extents from being double-allocated.  Is this an
> > > explicit choice?
> > > 
> > > I can see, for example, why you may want to allow the following in the
> > > pending list: [Add X, Remove X, Add X].  I just want to know if this is
> > > intentional or not. If not, you may consider adding a pending check
> > > during the sanity check phase of `qmp_cxl_process_dynamic_capacity`
> > > 
> > > ~Gregory  
> > 
> > First, for remove request, pending list is not involved. See cxl r3.1,
> > 9.13.3.3. Pending basically means "pending to add". 
> > So for the above example, in the pending list, you can see [Add x, add x] if the
> > event is not processed in time.
> > Second, from the spec, I cannot find any text saying we cannot issue
> > another add extent X if it is still pending.
> 
> I think there is text saying that the capacity is not released for reuse
> by the device until it receives a response from the host.   Whilst
> it's not explicit on offers to the same host, I'm not sure that matters.
> So I don't think it is suppose to queue multiple extents...
> 
> 

It definitely should not release capacity until it receives a response,
because the host could tell the device to kick rocks (which would be
reasonable under a variety of circumstances).

~Gregory
