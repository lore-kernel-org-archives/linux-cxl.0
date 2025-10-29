Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE963254A7;
	Wed, 29 Oct 2025 09:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731592; cv=fail; b=WFvMleXxYmL7EY0NUr7qxqu6EbbJ0XH2HEBWX/U2tanwWT+Xpu1Lyro48UmyAhH3F5PT7PWHsCk2dySisYYtC85cjIPa9E1CSCGt1vByugp+y2Un3ol9Dvr5G9E85OGxC4r6OitiRGGJKbOh7/XFQZ/H+XnqH4jok/tuAdCqGHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731592; c=relaxed/simple;
	bh=P7KaKrJQYkdeKPtiqIcL+5bG8MDbAJYpWUPW4sQVegA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a6OMXWrm4r2Ow0Xz0VM9MAEMOz1EGTVIADNrCAyczTf4u/kPgOmmqNlatXLrR2M5VI+0AnvVwpwVztqWDEr9gEXpnBdIAVlXgwJxnhOvxQnhnP/VRtJ451Cr28mRChr/0Sm0m23Its9EhhcRiAE698ZcD/0KXdlMc3/Q/IcX9vA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q0Z9YPoR; arc=fail smtp.client-ip=40.93.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q0Z9YPoR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w8rLm3tCzI1hwrU+kHHKS0VTZ+y17Bl/x1P23G+qEqX4juHQ234DOTJ/CDDEKFv9P9YXchSc382kZbI3YF3CfamUlEFoGsWNUtwz2zNPQ54EqfWTNYV83BUVZd7VsyD1Nb5HOiwMuAqEEcK7c4DfkyETuI25JTKeaLODXHk8hMD18OJDGzP7qT+URoKT8pzW7d2zogh0KTowP6PTiLfHZ0skDrcGd4KILGr8dzOfKqQvZ4FJ4HUwFR/cdMPRFPfUivP/Ib83IZbN8uUUESKcnmOWPMfGgMLI5/Es9IgrvZaNrkdPYIYw0ieS0OyTXHC4xMSuVhMtF5DxKxLnp2oDnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qdiGwptbYkH4CD7zzKp7x7zpTMWQumMwcC3YzuIy8ig=;
 b=NZgcihV9HePc9/p/NxmOOQ43Yg4c8B9ZcRDd0i7GAUKAREw+oR9H1v4fPlhF382U7GEGB5OoKZq/3jugd509+fL//NSClB0eI8wtSGlxBcjdrN113CQn1w1nUthH8JczvZrs24kPv/MK8lpn1EV/JNq5/Z3maSMUxmyuZ55ur3e5YlGw0B3F1cDc1MslhhcjF7suifcdFq2mYRXEJwEJPJnGmK1UZJp6V5c9JuCU8X8D2npFRGinva4V35kpY9W3w6RILt7wR8VGpTipMOpmkioqvbaM14vkGEhDcZZTVQhUETxul9Dq69MgT7oPOKqgmFEZBwjN6Hchza6UCoYagw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qdiGwptbYkH4CD7zzKp7x7zpTMWQumMwcC3YzuIy8ig=;
 b=q0Z9YPoRAsGSkXb5lluSwLSZ3PV1qcXw1tLWOPC4R3s65oAFI7VW7M/tVYhHXYbb5SBvZBtezjLmivgaM/PIyU56/DyrQdQZGw2Kf0EGpfAur1pMSatdQ7D05tsCPJD497RuOVOZ6psZM6iHa0VoSTnsfIwAQPS9rL6FxAU+wus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by CY3PR12MB9630.namprd12.prod.outlook.com (2603:10b6:930:101::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.16; Wed, 29 Oct
 2025 09:53:06 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9275.013; Wed, 29 Oct 2025
 09:53:06 +0000
Date: Wed, 29 Oct 2025 10:53:16 +0100
From: Robert Richter <rrichter@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH] cxl/region: Support multi-level interleaving with
 smaller granularities for lower levels
Message-ID: <aQHkDFJsU0lg7NLT@rric.localdomain>
References: <20251028094754.72816-1-rrichter@amd.com>
 <20251028142727.00003f91@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028142727.00003f91@huawei.com>
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|CY3PR12MB9630:EE_
X-MS-Office365-Filtering-Correlation-Id: 4065888d-b2d7-47a7-81d7-08de16d0f59c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l8BoB+WQEzD/FK8qQNwpyEpHgSrYof6JVZHfWp0yjU3AU1BXF16yjMbE/gqL?=
 =?us-ascii?Q?7/QYmUktRITCeOrCL8ypyt+8QGMKToZ4R6dSFWqP8QYtJajhaGPQGkVUMt4W?=
 =?us-ascii?Q?c67LPLEVyvyj8Bjf5RGcWs47IvomN5k6+w3BdkCnnWJhvodyt1EOD9V2a2eQ?=
 =?us-ascii?Q?ZQzYZPiCmefkijtOu6nERc7I4ifbpqwFQgNerzM2LwCFDZw5WudAflG6xhbQ?=
 =?us-ascii?Q?ZRKwUwHdi8ci8XzxncDFma3ZlRVTYZav7083RjuevjH/sEJvBI53CzOZvDIS?=
 =?us-ascii?Q?WjnFJS9O5oLmlsNaxcg79L+Z11L54q/Cr1otF41vg1EPXiFuqdEyPpfC5Gda?=
 =?us-ascii?Q?9lNjarG/B11M0r16fAGxuAWZ79lQdcZYq1LLEIPUCCHS5lhjNqHKaXe/CU/x?=
 =?us-ascii?Q?FST+L1uD/YwGabS33UD5s5EcKGpJlcRJg1Tv7Un1aRfg7WRW6rfA2pUdSlMV?=
 =?us-ascii?Q?7D6SuGIqfq34WD9xFhaXl/j9dgeyasuH9hL7Sivd9jGJvm9YXiBnY0sJn/G/?=
 =?us-ascii?Q?OUEEfvvRFbrbApTmGXsb/wdxSWu1k3jyIoVRoQzzdxZ0Q0EDX73lhjnzuuqu?=
 =?us-ascii?Q?BULZMrVhGNOam1pfNeSxO4E6L0rrsQQRAmWPiNH7pXySKZER7X9VJWlX+AON?=
 =?us-ascii?Q?+AT9HNOZhiHLm9YXfhVyZHqQ8YEe40ZoN5cTE3bcbjToAQZMVaZXuJq/g5E3?=
 =?us-ascii?Q?Czu7kMQu4zCZShZR4oyt3jjH7MfIGIeSM6ACJ2+ayLZzs1vRZqpShPYGMq0P?=
 =?us-ascii?Q?A6g+isJi8RQ6WsoWnraLDKJzkcYTAbpGvD3DOg78wG4HcQYvDmFU95Fx9nks?=
 =?us-ascii?Q?Ts0NS9iS4Y6YVQZEbY006BzdXNygNc/eGOBuwZKf9JT3pHJH9uL8LodGUd2U?=
 =?us-ascii?Q?IiVmuDDOIFUjoswxZYS6NNn/SDVvJA+e8MOCgHSlW064akxJwdDK/XMOgOTd?=
 =?us-ascii?Q?5CJ9Sxqi0pvVv0PA4ok4CxD84lD3x4wcW4GgGXGn4IKL3u5mkKylBU5ZcLyQ?=
 =?us-ascii?Q?panoW1t/9vzK+OrDjnJHDxE+2he32MXzyu37RvoDIy7q3tNX50pHx/Fqairz?=
 =?us-ascii?Q?gR1c1BGxcQwh2bjWzYJ34jJEI9zt+fOL5Ik6q2JprjM5PVynSBAJaR+tIZpi?=
 =?us-ascii?Q?tsFmzj03J8yVHJ9c/tSLrSmsW/S8KSjtroaLoZWK85SVyt6+1f3aonj9AmpR?=
 =?us-ascii?Q?+YbqY5Trbkwk/qW38OsT6z42TwM2BXdECID3SvHpZNUwU6RX4qQnPfT+M/MZ?=
 =?us-ascii?Q?wOeUUfVUkoZ5Pub+C8oGHN28rxJ4LbVfdjlKII6kNmYiyYl2sYu9c51xYV0p?=
 =?us-ascii?Q?A6M8eOcnaR81v10s2LvmEjek2y0IAR1Vw4QCUaMAYOeHZuhCgoY9sbnV8MT9?=
 =?us-ascii?Q?f7pNjV4IVhPit4zqvW59qqxa7Udo9Hl2ude7DR8ruB7r5lNbbGJmObU/VR6x?=
 =?us-ascii?Q?0op5I9NArdeXw02Qcyyq8f3Fbl51nj+3?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GpC1qOxjBLCZEabTT9f4mRDuKfxksC/zNcOhxMRtqau5bKkBQNnyjHCB6y83?=
 =?us-ascii?Q?60cEhFg2bKaJbmz+ZDWePvpiobzZ1KJ7sei61LxVmASZy1e1m9dHs957D/hE?=
 =?us-ascii?Q?sEeknOULmjJ89XSyUYLrSVxR0/gYH7Wbfghz961pg4atpg3+KTgp1AIcxCgn?=
 =?us-ascii?Q?NIAZIuCzLBkC3kQzJdr4izMPLXkLqeCicPVDCa4xPDevbzTuH3tNGdz2k559?=
 =?us-ascii?Q?HJusNUY+nlJJ9xb1K/JC/k6e7NwRjduB925H2D8IGwa5wAf3wUixtd1n62q4?=
 =?us-ascii?Q?PMfbIPvCChC8fT3NhOB9UgE6AJJP7F1+Em1UAmEbUnKcls5IbJ4fE1YrRGU6?=
 =?us-ascii?Q?pqIRz9eUiXC/x7PyEOF4IWQgmHh71Q/Gguh7FQ+6c4Ml5PHWOUZEIp4qMWN/?=
 =?us-ascii?Q?EqVy3n+tNOB/YIf0rJi77QMfPtH0U7c4duuqbtM6//Mtuy9W87ar2azMvki1?=
 =?us-ascii?Q?BFL8f5mUIcOmnBItxDH+oj1ovzXse23SGm0QR8uGe7L2gKo6ccbAJVDQitQl?=
 =?us-ascii?Q?0tvaTwrPrGupgVPUmdbjquZN23WWzRCSioPac8TOJB3/xQU7lF6dZnumcQ8e?=
 =?us-ascii?Q?x+HAD5zxMpeWMoXsQtiWXWizEdbkMaAjlxGICK2HdZ4ZPrX1jPdyEhx+dk7X?=
 =?us-ascii?Q?+L/WQ8TFwQjSwIYJgzUFwCagFLFbTGTgYDARDRIluL8gMz4YymVOB+6qlLvw?=
 =?us-ascii?Q?9kGCYiTGh+j1kqsfiyKLijJVDwoEQKipf+XZOceD96985aJfJkOH6q8DQG5V?=
 =?us-ascii?Q?4k1satgeTtDFv5I+adUZ/JqjMBVp4RgLISrfatVyxPRNg1ZHctTAHIyRusid?=
 =?us-ascii?Q?1Mh4MSMI2UIr5Nx6U8mnnI6PbpSmZ0gm+ngL8v30EpIIrChB+b9BKGvDSBX7?=
 =?us-ascii?Q?K5cmhjYwpI7oEsGspga06A8dfE5YtLNicWrbmEoe7xuDD8ghRJCoIjlCYF+m?=
 =?us-ascii?Q?H4DX9IOb8KzCICqYfc0d4atfvs5eMdyjPYEyZOMEVhI7adXfsLagHtX97rTD?=
 =?us-ascii?Q?hqYilYPU5dAwpKk+24jeSiLKmm17pQ6Es2aXuBA9ZbnId9XENEr2qiBO7dOI?=
 =?us-ascii?Q?u9BhczhSJ8GrJ+NWJ+m3DaILMGzaFFJZCv9zNVdGOJWldpZOLmLE9cc1PpvG?=
 =?us-ascii?Q?RrTRzDK8XfcQJhRWiXzeZEmRjLICp8Ccw4uvZW3bo4L81eGMcy3gy2tI52E5?=
 =?us-ascii?Q?aK/PK/oc/ZPwwUVIpriiRQkXNTQA+xKZXOkspGxrjpyA895Ly7gaxNoHklRQ?=
 =?us-ascii?Q?5KfoTUyGpvQpkRts3hZVQ7kYSGe0pAgCGIHsalQosUybkL29SEIGErNkat9G?=
 =?us-ascii?Q?Qou+1q58n9O28pZn0oKdIkLoSeBXQKD5TbyBXysBviyGYgg1GuaceWDvgl/8?=
 =?us-ascii?Q?chCFMtxKw33QnIriVQOBNg3qVB9pTjvFgG5EY7AJmqOVSHByHTfLuotBhXjH?=
 =?us-ascii?Q?aG4XLmJ2GyfH2/MLNzW4Mhc5+oO3YcnjK+Ub2V4X9E/QJfnyVlfB/wr9TLl4?=
 =?us-ascii?Q?ueboVETdt1gCYvxSeEdysW3v5RPwXomyMNqgiTvnWuqd0MYLyrAu1vIDhgW0?=
 =?us-ascii?Q?IXsRxyO7699/nYwcQjTFmjlo+6Gdua/Bnse9tXDo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4065888d-b2d7-47a7-81d7-08de16d0f59c
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 09:53:06.5210
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kcqJ+Hubp0+ttdCGGxZiCNr+/6ZZPjEDYgCtcE84Z0TvNVZmcTEv/ZMx5nfiJT7i/C5rDNQSJ6+cZhHSxca9tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9630

On 28.10.25 14:27:27, Jonathan Cameron wrote:
> On Tue, 28 Oct 2025 10:47:53 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
> > The CXL specification supports multi-level interleaving "as long as
> > all the levels use different, but consecutive, HPA bits to select the
> > target and no Interleave Set has more than 8 devices" (from 3.2).
> > 
> > Currently the kernel expects that a decoder's "interleave granularity
> > is a multiple of @parent_port granularity". That is, the granularity
> > of a lower level is bigger than those of the parent and uses the outer
> > HPA bits as selector. It works e.g. for the following 8-way config:
> > 
> >  * cross-link (cross-hostbridge config in CFMWS):
> >    * 4-way
> >    * 256 granularity
> >    * Selector: HPA[8:9]
> >  * sub-link (CXL Host bridge config of the HDM):
> >    * 2-way
> >    * 1024 granularity
> >    * Selector: HPA[10]
> > 
> > Now, if the outer HPA bits are used for the cross-hostbridge, an 8-way
> > config could look like this:
> > 
> >  * cross-link (cross-hostbridge config in CFMWS):
> >    * 4-way
> >    * 512 granularity
> >    * Selector: HPA[9:10]
> >  * sub-link (CXL Host bridge config of the HDM):
> >    * 2-way
> >    * 256 granularity
> >    * Selector: HPA[8]
> > 
> > The enumeration of decoders for this configuration fails then with
> > following error:
> > 
> >  cxl region0: pci0000:00:port1 cxl_port_setup_targets expected iw: 2 ig: 1024 [mem 0x10000000000-0x1ffffffffff flags 0x200]
> >  cxl region0: pci0000:00:port1 cxl_port_setup_targets got iw: 2 ig: 256 state: enabled 0x10000000000:0x1ffffffffff
> >  cxl_port endpoint12: failed to attach decoder12.0 to region0: -6
> > 
> > Note that this happens only if firmware is setting up the decoders
> > (CXL_REGION_F_AUTO). For userspace region assembly the granularities
> > are chosen to increase from root down to the lower levels. That is,
> > outer HPA bits are always used for lower interleaving levels.
> > 
> > Rework the implementation to also support multi-level interleaving
> > with smaller granularities for lower levels. Determine the interleave
> > set of autodetected decoders. Check that it is a subset of the root
> > interleave.
> > 
> > The HPA selector bits are extracted for all decoders of the set and
> > checked that there is no overlap and bits are consecutive. All
> > decoders can be programmed now to use any bit range within the
> > region's target selector.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> 
> We debated this back when the original support was added. At the time the
> discussion pretty much concluded there was no reason anyone would ever actually
> do this because it mostly doesn't provide much/any performance benefit and
> might result in significantly worse performance by not spreading out accesses as
> early as possible.
> 
> So do we have any idea why a bios is doing this? Something about the
> host interconnect?

There could be platform constraints that require the cross-hostbridge
logic to have bigger granularities. The sublinks have then a smaller
granularity. There are existing platforms with that config that would
be broken otherwise. It is not possible to handle this differently by
the bios and reconfigure that.

-Robert
