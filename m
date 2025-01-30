Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0351EBFF5;
	Thu, 30 Jan 2025 16:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738256292; cv=fail; b=dhvVvEzqKtYNy3fsvdItP585YdfE1Z1LxBdunjHAl8XB9q79oYTWv6/r+uAWAHrwfwTMHayP4YMHQ7bJgK1yVDJ6GhjEaH53t0i7co5eRXlWoCoWg3ejnsgnhS/hWBGKkNwl/oP5Ulr9gi/MOLw6ihmXpRtXozHLIP4S9D4WIzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738256292; c=relaxed/simple;
	bh=67Sf4kj+NPHwOFd/g7rKSxgWEFZnAjrEqa0QCQGlcjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A2sX8IYv9StkqaHSMqTpNLqeFU5O+GDDqCLdhhoiQtY5rG+TDigU5W3iIF6FulfMoTrQoPMyM9WWq0b0V6Zyqos0B0PUrO1wNNvkrXTwyxfsDgleK+GiVZDEC5JvTSK28SUvuy6Rz6qMkbpBnEUjyS7rpIqbL77iP6haM2nN4G4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kUcAqjBq; arc=fail smtp.client-ip=40.107.237.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kUcAqjBq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drnIuv2VFRkbHN5k5gxfn7csglRfML4sN9+DujgM2OiVgshZJVcq8UlakiDfdp0iPomG0lw3vQiBAiGronC9pbkvLFxuLTaLchcYnls+nRZSNgHDT5dOJRGBPVVgMhDttEL1t5Cz6+QWfk1RFzk9A/Xos/sI9MzP+5wXGLgguQU8H0CFKS/Zp7Gcfjzb8gYbUUpB+jCWw6YmMYePnCAhbJgD5MyAV16XuVinDIoPBUUCmZGOpLpz4VfIYYr1+/iw9g51VK0ZtIf7ytBy3HNE1LwzS9NVjKxlv5q9TxpMSmbsGT1cGmh0vcFjrY/MciIXlzxAfoDTEJrIUE6IF7pgsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k3as9289OuXQsMYXQuPayuOoJZ5PbmCjX7NduW8kAkk=;
 b=RBiHVkb2AnCV+xIR9+NWIiIxkrjhbKlKdDM+DXo9OOzN2+/YpVUdlP98RJYod5DcZN9nD/mSqDQPijS9xkYov+5IGxTpRC7tfb1Xl9oJYTSSZfD4a8Gl7S237nAue4zhRIQ9EqqqBoMKCao5bnAfoODeEZw5z4tdcAdwuLCEbx706LjQWSOj1sbs0FqowX74hvNOOlGqYxH3uejM+5C5F6NtH/T502ZusGGhNgOtetzYSU14JSg4PfDBbaGYeaDd4sn30x0Fe6NEBBflib6yByaJRIjr9i/xFjvCaMxXsdyh53Ku6vc/dSwwE14Y4iV33pfJzk3nmRNMTrbH4EzAIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k3as9289OuXQsMYXQuPayuOoJZ5PbmCjX7NduW8kAkk=;
 b=kUcAqjBqGF9wUYmzNKfN4WUmTpCfsHXvF9X+X0wK3/I6OXLyEWK1qnMFjOCP5X9zJLCoAsjWzeZOVpTNEdTW+3k3z/P8fMvJ+PWBdsNCO/wWD2kEXigxnhHFnqVCjEGwhz5Qdt+MOmOtXR7eD4d8cp0whe4yMmR5/Kg0i+VGkQc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by BL3PR12MB6644.namprd12.prod.outlook.com (2603:10b6:208:3b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Thu, 30 Jan
 2025 16:58:08 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 16:58:08 +0000
Date: Thu, 30 Jan 2025 17:58:01 +0100
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
Subject: Re: [PATCH v1 10/29] cxl/region: Add function to find a port's
 switch decoder by range
Message-ID: <Z5uvmZbRN8B7Gwu1@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-11-rrichter@amd.com>
 <Z310qYmGmGqqhY53@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z310qYmGmGqqhY53@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR5P281CA0040.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::20) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|BL3PR12MB6644:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d14f905-dbf3-484f-3220-08dd414f454a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F2G6yY+KWM1rh+2L0EIO+g1weTTXUnNo+4R3/To+GX34drXS8ubybqWntYk7?=
 =?us-ascii?Q?Gst8j8P1EXXgZug397292lA89KvFGSYY2FNPwa9JhdCahue9Ew4uWU6wuwcd?=
 =?us-ascii?Q?SH+2voYf2nNPiYaGSY8SMtfP0N5mtypn/TBv2SlWUWt5Kl5DmxIq7WKFHUDg?=
 =?us-ascii?Q?Is0LNdIGny21LIzrqGho3yupy1XfQQ8peWd3e70M/F12hl2g4cZEO3E8c5pi?=
 =?us-ascii?Q?pftKitFebhkj4PHptjj7J8zsNoUEYD+vFD3KNVJ0pZlyWHOt7x5KKzUNzong?=
 =?us-ascii?Q?M9GzAal6D3bhIjUb7GGCuYUA8z2piUOdyG7DhupsT9a7Tk9N9DpLHjwRa17g?=
 =?us-ascii?Q?GS/E9jgk754Cp/dpnJXpR32RU7eFq4acVeNBhJsOYR7A7MABg7w9Astr9JXM?=
 =?us-ascii?Q?LnHY3iP6ySPJdXGBJvK0dc6oorpMrphlIzlgfVhqkbmw3U27NFLbXvsRxfCq?=
 =?us-ascii?Q?nd7UIqaPtyGcTjJdShNQiQgaESXxr3Z6ZCH9hBtjZKIfgYv1n2hRveE8KMss?=
 =?us-ascii?Q?JpktazcTl37+jcT3VYBtYCrXqk4D8dm1k5f0Lhdd+cPWG3qiL6c7wLGjZba0?=
 =?us-ascii?Q?9UHT4SevGuaOly1XEDs/bs2FA82qimT5kIDnc4r9Yhej4C/9cu33aoSJsBDC?=
 =?us-ascii?Q?qbnTAprNsL2wL1rMEnOH713Wm2TuMoiZgYWs13wDtCYsQqjHEtjKE5P0i92t?=
 =?us-ascii?Q?KPwZ8agq7CHbu1vWkzlz5kvVCLjuR4dwA73BDBRRUSuQZBvIcJfISykCl2cR?=
 =?us-ascii?Q?Wj68nrG8ZYivDyp4N3grAk3Tx6iRsNCV+lZgoCrPmHONtI7LsSkuBAnMZJPr?=
 =?us-ascii?Q?+d3GVl069HYT9Km3VGn3Qq0y+HexOPrARd+pLtaeNkXR2nNM/yFIbYCft16C?=
 =?us-ascii?Q?l4vEKHU3eXVZckwwygX1/hOte6wku1NJ2BdAf0U4abO0MegOCDsaVLtDPbua?=
 =?us-ascii?Q?S4/acnmN/zusbPCoO0byvgZh9h9ItfS43p96Y5zcwWkJEPDDrkDY/VstS/Nb?=
 =?us-ascii?Q?uG3bVYbrQ66yFItyE/wSNCZ0yIEcc7BOTDYtC99hIynYMXHdeLoljn1Yivu1?=
 =?us-ascii?Q?A7P3hQuJ1tLsBpc9UDXx4KpeOf8k+vT08tm7uFqrWG+iM7NqoK5Hp8RkydvV?=
 =?us-ascii?Q?hmiw5FDDqvKHWxXpJK12icrUYgqGJqqWOPVEDay6lMuvkVGvN38BDiUUCqW0?=
 =?us-ascii?Q?Px1k9K5q/zuChkLmBNSMH8sARtub/bLSKZfMnZ9ole9VxLE6ZkvCsCbdlwBc?=
 =?us-ascii?Q?res3zFXFYeivm2MsIVUQsa0sJynDAO2m1u3LkRagj24b66z9bENxekKZt6j7?=
 =?us-ascii?Q?bUNZrGYcYJdHjbl9cNPy2TCal/T3K7bEbi//Nl++3wW+IKIFj5oXS5SbjuJB?=
 =?us-ascii?Q?PQBIIY6vjcBd9N3A/+Nm1EhvIwgC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lr28zyRtcaARUuU3dsuaG6upOErh195kFV4uY1Q37kjbwDHJh+yqOGwaP3nf?=
 =?us-ascii?Q?ePD0NOGa6IfeA6qSHP89Xjcm6HhvslKtyhsUv/2hoLbswDLvODsSxOfHdbEq?=
 =?us-ascii?Q?gB3YV+v2L8DnrVurv6MLPBv1FVUlqnCUIzMNhxAAabWXRnb6FtfNfHJChQ2O?=
 =?us-ascii?Q?8x16U/TEguJOqHEBZAtcw9YZe9Y78/NPiTPIoHFtsIM04QwSbwJ0IP78hv1i?=
 =?us-ascii?Q?cTRXUk0khNbkeQW1awkmXwMAQrlUdEgSQc2eulNxPrL0bSaYARBEuGgziKcx?=
 =?us-ascii?Q?5DwalfbSmQz88wXJe/E9d469+4em+Dvd50NlYXlOB/F4FTsygjRPIx70pL0C?=
 =?us-ascii?Q?JKRt6BvXROpNmKpvJaydqRC2ERqG82OQ5y3GRYS/Hx2h4fwY+VfewYxFziIm?=
 =?us-ascii?Q?7mPrSAgmsFwrg6qpxIA81rPAVpuonFtqwowNoLogYyblr+4UJUyIoy5k/3+m?=
 =?us-ascii?Q?iTtaMFURJ2+LFcNQD6RrBkYNAUFBXexy8DqBxshmSi7d2TnIAar/jhxZ0b+P?=
 =?us-ascii?Q?iSiyc71MTSt8ZGJ7Wuy4NGCgV/gEEvUFUtRHJC/2p2d+slUBIrnVPf37hljl?=
 =?us-ascii?Q?76SnwG+svqmOmijtxFCYlYfch/PeqwEXv1yKPfdzB8cnQ1bzbQt+oL9j4TRJ?=
 =?us-ascii?Q?rzsobDWgzEDy02RX91cEVlyXPrzCyJ53Dc+cAzfG5zY/YAUC/TKFykTJu6rp?=
 =?us-ascii?Q?HbYf5Np5+EXdevEozsuZgkGInqc9fRumFRizMjjmSICYAmJkJmpwXKhKJ/JM?=
 =?us-ascii?Q?XNGiXItvdc9xzC9AgMhNxrKonxNhduxmuIzl+ZZXDa1EjgkQEi1AmTaqvg0K?=
 =?us-ascii?Q?LQ1zDQlx6jULQYWZTK35HflyVIPNF2ofroQ8ay0xBPGzOjlkMOFxCayRV1r0?=
 =?us-ascii?Q?v1WVHOV7B9HgA5/ZRz5gTnpXcIrpXkNkxVqp/M7tIv5MOxeisYPPFGBRn4pW?=
 =?us-ascii?Q?xY/OnxTVXmBl43utymQZV8iZxk/e90ZKkrGvz2gA2sSq03h4OuhHLTD2cBr9?=
 =?us-ascii?Q?EtOT6KeniSJX3xihxGKFvjDeOJ3d/UILsEYU4TCGgBKl19LG+CvO+0vk6zjq?=
 =?us-ascii?Q?1I8Zi7aFYEkh+182y9Pn6uofieZF4KRn9PQHw8KIDScuaRCFt7LX7GQttUSG?=
 =?us-ascii?Q?C324AVwLkJ5PLqnyE7bt/idRX07LPsB1njclC/23MdOlzBu1BnrTmoRh3MeK?=
 =?us-ascii?Q?IeTTfguxAnHCKNHQbjZDsjWXr9kZKbqxAmlGYtVgK5Q3kXAJy1Adj8jhqRR5?=
 =?us-ascii?Q?Nnwh7gFO633SGGCR1UiXEAG6B1en0QZHTZouSSGHh8g32f5Q5ifDDG2omHGA?=
 =?us-ascii?Q?Fp7lfIkfw1ecHCUXWrWZa4FKaYM1zjljAhj+La/V/Zdkxy1BBeKmZ2he2rVj?=
 =?us-ascii?Q?BZw/7T9E+u+dwkjtc48ddhvcZm84tbThmjoQCDzHcvAVYxKRiw90jaxpKvTn?=
 =?us-ascii?Q?7NVuvkO04ezPiu3+L3+2EXl8wNZv9nxYqNsx2pbm21ITNkVqQEIiJ/gOCLWR?=
 =?us-ascii?Q?uw3VnHXlxDW1ewXD97fjyDVslResBi+m7aRmoWCn8F1nG4cox+imO+6ldAgr?=
 =?us-ascii?Q?lquu50xRgKNzMwGwH9tKugBSe8U/94gITrJPq1xU?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d14f905-dbf3-484f-3220-08dd414f454a
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 16:58:07.9225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BP9AzRfiYWOqIunb2LTm0iM6WZyNAD/kNxwVEfR4yt+MbhAaVgAOouLwWEk27HyXqBJatEmonHhzz++ZNubOBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6644

On Tue, Jan 07, 2025 at 01:38:33PM -0500, Gregory Price wrote:
> On Tue, Jan 07, 2025 at 03:09:56PM +0100, Robert Richter wrote:
> > Factor out code to find the switch decoder of a port for a specific
> > address range. Reuse the code to search a root decoder, create the
> > function cxl_port_find_switch_decoder() and rework
> > match_root_decoder_by_range() to be usable for switch decoders too.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/region.c | 43 +++++++++++++++++++++++----------------
> >  1 file changed, 25 insertions(+), 18 deletions(-)
> ... snip ...
> >  
> > -	cxlrd_dev = device_find_child(&iter->dev, hpa,
> > -				      match_root_decoder_by_range);
> > -	if (!cxlrd_dev) {
> > +	cxld = cxl_port_find_switch_decoder(iter, hpa);
> > +	if (!cxld) {
> 
> Are there scenarios where this would return a different decoder than
> previously? For example, is there an assumption that root decoders
> will be search first, as opposed to intermediate decoders?
> 
> The match function was changed to check is_switch_decoder from
> is_root_decoder, i'm just worried about the case where we might have
> multiple decoders in the path and the switch decoder is hit first -
> resulting in the wrong decoder returned.

Intermediate decoders never share the port with a root decoder, both
decoders always have different parents. So depending on the direction
of walking the tree, the same port is always found first. That is,
starting at the endpoint, an intermediate switch decoder would be
found first. Search is always deterministic.

Note the "root_decoder" is a subset of "switch_decoder" here.

-Robert

> 
> ~Gregory
