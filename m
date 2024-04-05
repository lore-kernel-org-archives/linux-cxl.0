Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2099.outbound.protection.outlook.com [40.107.243.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460FE16EC0B
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 16:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333307; cv=fail; b=AW8PiiLifbSbtj+Ve8oQFH0SHy5qkEdjNjwoRG5J/ZIGmUmbyeVS60vQYPisp9AmGV1pNW9dNjoQVnURsd5YxV8UuSWtoNYctDCFCbW0yMBZ02c9mew4MNLgdKX1VJ+jEP0KpfULuk2GIWeR8ah6ERU0YnEbCGHbb5IKmQcgWvU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333307; c=relaxed/simple;
	bh=thnMw9B5hWo/h/Xn8JeyOQuAK9UIHIN9Jt1aC7Tdduw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oiVUSe48xOPlftYySNX/4QH08zx0e2upfYI6jNpnbs3wz2Kc7whAmZZde/ONeXDvAu/zNgC6z61WjHMA8PLz+YwXlP8xKC172CEEX5zjx1vfijhlkf0CCwI0uDXQn/uVrRt853oThI9njrxQQxwUzfTA9o3H4UDg4x/Tpxmwkro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=ADeR+37F; arc=fail smtp.client-ip=40.107.243.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="ADeR+37F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bj4UuQ1tAAKdzlHcgAcouRcED2q8EsdONu6PwVdY6Lxyz6Wcigv8G/s7k/WSeVl4xXCVhbbetS8DpMed9BuNX4T3JiGfS8sMOR0hOoQ/sLHFKtF6FE190KRWfup71FHtZejZBGVpC1nI/4dNyjdlvrJQOnTYENz+IF24lZj3jdmDXEDF0Rqw7e9RZMmQHedYZ4Xi+ve7UvaTww7w6uQqTSRV6sMu7SHCEc8qfatq6w8M9HeeDPvL4pfbspBPY2499GobyusDO9VickczzKK67/Q++OvbjtzAj+XkW8J44+d0AgJw7t7y/pUwR9rr8qexLeexD7aOLi6krl0qJPfCRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oTn+1CuJCZZj5KOyDlgVA2iWECIrCdkDDA7G2Nk3gag=;
 b=WfuBLB9i5Ta2HyHOQ3CNmjji98eXwQcgrJ3xBLHbNXwRtBNItUJxuyj43tJ9GLbNXUsQLwthb6BI9Min++5VaeZELDUkeks54RFPJ8rPmNuBeeO86E6UvHxk0ub1lgyiRWcKNxTDf5h7LEntYJTD1ZHnaAMrdeoc0Jw1a+Dj6SfmXjE6Sszv98icGACGeertdPpt82HFQNyuePekyApnUd7Jm5CCH0sFNz7xEPImz3RfZI60evCHN5//dHq88UjDUZ8ppOan9ctUUoNvLuqFmoP4CECiDlY3iBfuC5uOnEIezy21LnomAEBS00pzSunZbpwit2XmJt+guAcEU+9n0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oTn+1CuJCZZj5KOyDlgVA2iWECIrCdkDDA7G2Nk3gag=;
 b=ADeR+37FU5cHsmZl1Xu7d2a7S0QiIZ52G9+E0glHXfswfYl3j4VjtONGmxvm1todBeRR26okj/7aS32e1hzi4HvuKFiv4Rgb2rYIPbUG283xv4dMbepFteYBLrl9Gv2cBYbuLC2ma1kemqh1bbkHDuldkXKpQBrP2XzhhCw8/s4=
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by BL3PR17MB6116.namprd17.prod.outlook.com (2603:10b6:208:3bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 16:08:22 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b%5]) with mapi id 15.20.7409.049; Fri, 5 Apr 2024
 16:08:22 +0000
Date: Fri, 5 Apr 2024 12:07:45 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	a.manzanares@samsung.com, dave@stgolabs.net,
	nmtadam.samsung@gmail.com, jim.harris@samsung.com,
	Jorgen.Hansen@wdc.com, wj28.lee@gmail.com,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 09/12] hw/cxl/events: Add qmp interfaces to
 add/release dynamic capacity extents
Message-ID: <ZhAh0Qmv2/VTe1wT@memverge.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-10-nifan.cxl@gmail.com>
 <Zg2c+YauNGqhFfTW@memverge.com>
 <20240405132719.00005859@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405132719.00005859@Huawei.com>
X-ClientProxiedBy: SJ0PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::22) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|BL3PR17MB6116:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JmdvJXqP2iZPHn02uKEGWv+we0t8jrtbR1pCQEfRf+cRH1H/HDvM2AVB/dynDKD3q98GWkz99BTrpr7rUFN1AtpdiMy8Ra9Z2ykJ3EqBXopek/u5T11aHkBpdp5keF0FbWoa/x4yo9w/ZDdMXFigO299YRDMZb4iJ2W4BPvyGOcG3EDTCWsN5f156W6Gp6Rf60N4EahKpqgKhlUyojVSFHRQdnCfhtWd/RkY1yFEclQMlzlGmlKlPSVYTZ92dqkY5/m8852E5zCKhJHk7x/rKBM/fOqIvom3E/znLDJT4MFw+E+MroCq0WWBW4XRoSWO0S2BD8RRag8VB/KhaPPN/t8wssedldZoRVVLN+UBdMbUUsRluFHa16M986O8gB9mS8XuZdmxgt1qKxtZiEOMNLs8JZvSEh/Mb0cXcwlYBvKpp1MbrXIju2HYEITWwZOB8eCzR0vhU2aLMqQ/yRgOWFwmBVmRCN7+zhWg4lyPQ99BPNC7HRiDalFAR7XC+UmSJ1XWo2eDIZrMdq0vCJMJMfuFj5Cbk18hO+q/aEcU4AjuOjtFrfWFGiBE2LmCU5jS96uggEjhsuExw5hAjBIyPdWnGYw5jM/nttZX5ZGtnwbxaBc6wF0HpeJHVh0Gm5ZicpxVmBdrtLlOhWn3n3LRTV7l0ZFjMso7R/CWzS1T+TM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tp6ck+MI2MsBxItamrsJd6ceMZTNZ+DLxCpFIvFY69IoHbgwplXnalMWO4yf?=
 =?us-ascii?Q?9TRuymlakkOYri5BOS/r85vCGrz5GJ9SCGEdTiPWj/syjongD7IP2hMprPhd?=
 =?us-ascii?Q?eRLzYn6YbCsCPY+8/x2LpuFiPA2gJDDtPvgYCsZ0VrC/lX7ddSaksEjAeSDL?=
 =?us-ascii?Q?S/ljA9S4iPrlPhzclya+d1pTbS/l4R0H11fOtRYkb9Pgqnblb3d6NBIlqh1g?=
 =?us-ascii?Q?DSP4atBavT4mdU6K5n6e7DHzVro9BBQMdVV1kXolMC3DutFm8Y5UlxytCe+b?=
 =?us-ascii?Q?dOxtc49nS0pV+1kpU9UvZJJ6DlxrnZVy7b04OdbZfHG2r+Yx2R8Ct1vwUsV+?=
 =?us-ascii?Q?ifGSJpImUJSdjwPmLGQc+UAZOE8iLLYbn1JH0C+ozIfZylTW6JnNb8obtS60?=
 =?us-ascii?Q?Zq7mzdL/qJfirknPWCaUP43veJpxblGXcRgrVHaT47QM/+CkWOZLSDCjHc5L?=
 =?us-ascii?Q?UL8djswYouH7TfwDYJUoqGZ68Ft2KLEwr7LR6f7zdgWUgaeea4l3PzrgpAGK?=
 =?us-ascii?Q?bDoYL4wg1zoEICnoowbgJmyC8bmHsdaZjMnn0QUoy+xW1PLDrNssSr84jw/L?=
 =?us-ascii?Q?SQ2xw5N8HWD1idf8QtjE6C0rlpTXFfVYMZD7fdXTIfjCwxaEmfi4BIcIJsN+?=
 =?us-ascii?Q?SFJniQCsocV1eriPF1/Oda8q60bKOLNmX79PAkRj+RwYswpSu0+ba6fXv/QZ?=
 =?us-ascii?Q?FIcA2wuSHzBEHtlnwyMmuYmyx6d8KQM3HKS/DjLRuhgNHayvSRVztb+KRXa5?=
 =?us-ascii?Q?6Hp40yMV27E3/HZBKn+ExkI+59MespfYu/QnUv8o5X5leTgs7shvgLPRKpVG?=
 =?us-ascii?Q?Nx64Lq8w2uPKfrDasjWL9nQ09iYYW4oRjQuHSDRQdFcToSk/7+FXvJ4ouAzB?=
 =?us-ascii?Q?LsJGiuZEw+aTuNoWhtJR1nDI5EvkZdHY5C+qrVKPSvoZMTB5bToLPpD8XKP8?=
 =?us-ascii?Q?jB75z7P073k79rCsh5sIVd6doDiLubQNz5/NMUtgLnbVrrT17MLHsNWww50c?=
 =?us-ascii?Q?RQ9tsBN2p6sIIwgRIdv5msZ3BMRc8j6clp9HKH8U1OiMFnl41PU7fh62SG5J?=
 =?us-ascii?Q?wXd0WkRN0YRWIYRKIvZluEcM5XgR7x7pxowI3wLy0DPYLasiTtgSY4MQjBKb?=
 =?us-ascii?Q?j2jR4Sl/1U2dOvWHE4QQO+pl3TRVSWkmzE935HwPirrkjXEwU7GeMqw+s5EK?=
 =?us-ascii?Q?0omIiewk0+flBe3USfkmobjUtstMEbMKgukO8wY4ADKCxgDLQrM1KKbGBJXK?=
 =?us-ascii?Q?PDKgS62kXmxAruZtBg988XQO3A0quSjssQ5Hjf44lgUqbaqkxgXyKGGIINMY?=
 =?us-ascii?Q?WlYbzV1axgPxcrbIOuJ1o7PVgHSYRyyx0upR2MNTLVH871nOkXG8M88ab6ZC?=
 =?us-ascii?Q?920uyi1jcFw4kFp3o1FMp0gYcDNdgPWnLXKHRdtp78Q/TtvGabT2qCgehHGI?=
 =?us-ascii?Q?FvKBhpoOlcbdWkMlK0JLPu7sw8AxOmvZCzKt6IXBviY/Z4SIDaL+Vp5eH9Lh?=
 =?us-ascii?Q?IeOz5n2eImI60hs0ehZ7rJ7hnT5PMWFnFLVqupaeiJSU+HhP9AVIiHDMZ6bq?=
 =?us-ascii?Q?i+opz26/T99eJxk1ojdyrplxQiVTjImF9xmlmTtE/g/9Zvoe6wv0a48oFL3A?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd3ec63-2fdf-422c-2faf-08dc558a9dab
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 16:08:21.9929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bobGl4pBkQUP3oWeeTtq70EjIqDC6g1RCRY6RjKZy18RTlImTufcd2oFsb9+96Ax2JNtczXjY9MDKe75eZH5NIllV16t9B2SXd/Yxpur9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR17MB6116

On Fri, Apr 05, 2024 at 01:27:19PM +0100, Jonathan Cameron wrote:
> On Wed, 3 Apr 2024 14:16:25 -0400
> Gregory Price <gregory.price@memverge.com> wrote:
> 
> A few follow up comments.
> 
> > 
> > > +        error_setg(errp, "no valid extents to send to process");
> > > +        return;
> > > +    }
> > > +  
> > 
> > I'm looking at adding the MHD extensions around this point, e.g.:
> > 
> > /* If MHD cannot allocate requested extents, the cmd fails */
> > if (type == DC_EVENT_ADD_CAPACITY && dcd->mhd_dcd_extents_allocate &&
> >     num_extents != dcd->mhd_dcd_extents_allocate(...))
> > 	return;
> > 
> > where mhd_dcd_extents_allocate checks the MHD block bitmap and tags
> > for correctness (shared // no double-allocations, etc). On success,
> > it garuantees proper ownership.
> > 
> > the release path would then be done in the release response path from
> > the host, as opposed to the release event injection.
> 
> I think it would be polite to check if the QMP command on release
> for whether it is asking something plausible - makes for an easier
> to user QMP interface.  I guess it's not strictly required though.
> What races are there on release?

The only real critical section, barring force-release beign supported,
is when you clear the bits in the device allowing new requests to swipe
those blocks. The appropriate place appears to be after the host kernel
has responded to the release extent request.

Also need to handle the case of multiple add-requests contending for the
same region, but that's just an "oops failed to get all the bits, roll
back" scenario - easy to handle.

Could go coarse-grained to just lock access to the bitmap entirely while
operating on it, or be fancy and use atomics to go lockless. The latter
code already exists in the Niagara model for reference.

> We aren't support force release
> for now, and for anything else, it's host specific (unlike add where
> the extra rules kick in).   AS such I 'think' a check at command
> time will be valid as long as the host hasn't done an async
> release of capacity between that and the event record.  That
> is a race we always have and the host should at most log it and
> not release capacity twice.
>

Borrowing from the Ira's flow chart, here are the pieces I believe are
needed to implement MHD support for DCD.

Orchestrator      FM         Device       Host Kernel    Host User

    |             |           |            |              |
    |-- Add ----->|-- Add --->A--- Add --->|              |
    |  Capacity   |  Extent   |   Extent   |              |
    |             |           |            |              |
    |             |<--Accept--B<--Accept --|              |
    |             |   Extent  |   Extent   |              |
    |             |           |            |              |
    |             |     ... snip ...       |              |
    |             |           |            |              |
    |-- Remove -->|--Release->C---Release->|              |
    |  Capacity   |  Extent   |   Extent   |              |
    |             |           |            |              |
    |             |<-Release--D<--Release--|              |
    |             |  Extent   |   Extent   |              |
    |             |           |            |              |

1. (A) Upon Device Receiving Add Capacity Request
   a. the device sanity checks the request against local mappings
   b. the mhd hook is called to sanity check against global mappings
   c. the mhd bitmap is updated, marking the capacity owned by that head

   function: qmp_cxl_process_dynamic_capacity

2. (B) Upon Device Receiving Add Dynamic Capacity Response
   a. accepted extents are compared to the original request
   b. not accepted extents are cleared from the bitmap (local and MHD)
   (Note: My understanding is that for now each request = 1 extent)

   function: cmd_dcd_add_dyn_cap_rsp

3. (C) Upon Device receiving Release Dynamic Capacity Request
   a. check for a pending release request. If exists, error.
   b. check that the bits in the MHD bitmap are actually set

   function: qmp_cxl_process_dynamic_capacity

4. (D) Upon Device receiving Release Dynamic Capacity Response
   a. clear the bits in the mhd bitmap
   b. remove the pending request from the pending list

   function: cmd_dcd_release_dyn_cap

Something to note: The MHD bitmap is essentially the same as the
existing DCD extent bitmap - except that it is located in a shared
region of memory (mmap file, shm, whatever - pick one).

Maybe it's worth abstracting out the bitmap twiddling to make that
backable by a file mmap'd SHARED and use atomics to twiddle the bits?

That would be about 90% of the way to MH-DCD.

Maybe flock() could be used for coarse locking on the a shared bitmap
in the short term?  This mitigates your concern of using shm.h as
the coordination piece, though i'm not sure how portable flock() is.

~Gregory
