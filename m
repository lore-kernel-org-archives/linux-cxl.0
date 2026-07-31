Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BF119E968;
	Fri, 31 Jul 2026 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785489220; cv=fail; b=o+x7Nf9xP1fp+bREq4SnVGfYx45quFXGbWYd+rlNG8TTcAw7JvpTdGqZVFt3WkD077GJzdhk5OpF5kr6zoGj5LiAwCpxOSz7v05ghCBC0SB2/vc5cNWaJCdKbcjSUC3cuSEBZdE8xjGhmUYuuGVwLacXAcciShLWRaZc4Hl82T0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785489220; c=relaxed/simple;
	bh=t+n8c/4RfSpL2jUiLpm9R7bkWqXlHVRA+TFUredCs2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c0zRWh/rTrmIjTrp15AWePlZ9l7FNFP8MsxeEgD4UrP1EeRN2N86nLVuRCb3LgXxxRaEEu03iWjvC0UdDAc+0vAk5246iWzG+/Y2VPlnV6tElUIW1zKPhvTetcYS147qd8LpTJ1XfGtC4wVgCwpm1DPSxoVjZjDEZRMQesikvAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aTKvcNYs; arc=fail smtp.client-ip=52.101.53.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aTKvcNYs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDRQOIr+uvrlBYx4GG8K2ib/TaD75B3jtquL6OKRLxqjhVhSIhesuiWZDR9sufDlD6d/xmIEeFH7Ccpyp/lTvkHtxh0zewhU3mE8UBcOhBHV5tsOA12VN4E4guPV5Wmp5jRm2pOfGVbv9btUB4a4IpU4pVz/VjPQS5tMwVl46YvbeoOhYLaKs6On3CFTgVTJenMMMScVYEFjp51DLsxUyOH1OCeDXSYmScf2+h1UtEmO+ZWCJ85rnVhWzMe3t16XMBV8Q5s10IP68meL3difk/BMu5devKaKAfKbJha4TKEYY7it9zye3MikRDDuGxW7UJsZCZfgxh6G04CL/Tx76Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UK8FKWjIloiS0F5rXHfvWBgPsmtwFIiWhKLhceI7Us=;
 b=ltIgaSIQFAfAWxBavWtCwekiIvtgNevmlrp5mhACmg+WQLLjA+2GtcbZXu35/QR1K0u0C2EjDjukmhxm6/SsR3wawnsQ/Oo+Ilp6G00F2R09H1z/ILNgZTC4Iw/6iq38SajXrDZgw0/hnJdUP9E6C6d9oollf1nAwhaKKjdKOQjOIM1FRSSJkeNeVpN6lKKfxxiNReWirha98f6VYIyVDCROxUzh7x3WecZT7ZdDX5zobB3rTMDO2QE3KdAk3ygEQB5UN6JGH5wr1Odzv17i+cAw6odW5NcSLJ0eV6dQbE37c5ljeo9H3dFQZWUcLVJxyOedbCSS0USR5iN3gOh77Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UK8FKWjIloiS0F5rXHfvWBgPsmtwFIiWhKLhceI7Us=;
 b=aTKvcNYskJlYec8M7b/hUreXhpuJWmSKdnNcceyzmDYWueV7JOavZZGQJOJ9o4K+Hp5eQnHPBrIHCdrOr0aEZcCelwUcqbp+ulrXi84t3BQHAlZvz0rCqLwqilBFHr3AQuzpn4wC9PsLo2/pq4nXWtvEVqX30eC33Z4zoQFB6CQQ/rKCWwecA54ELaW9zhZenxIvJ+Mnlff0NJOBB+vWZL4tF5c+vnHRAnV6saCgrLYlR5/OiLQS3Sh1yHP5f90OyGl8RX1/plzQvsUnhGpHI1z0J6sWl/6WjbtKMVVV0vgtr4/FiHRwIsK8+EUiy3ghTuJzKV0yiswXKx4KlCM7ow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ2PR12MB7941.namprd12.prod.outlook.com (2603:10b6:a03:4d3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Fri, 31 Jul
 2026 09:13:32 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 09:13:32 +0000
Date: Fri, 31 Jul 2026 17:13:26 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Gregory Price <gourry@gourry.net>
Cc: Dave Jiang <dave.jiang@intel.com>, dave@stgolabs.net, jic23@kernel.org, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org, 
	danwilliams@nvidia.com, iweiny@kernel.org, ming.li@zohomail.com, rrichter@amd.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, sreddym@nvidia.com, 
	smadhavan@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com, 
	kristinc@nvidia.com, mochs@nvidia.com
Subject: Re: [PATCH] cxl/region: Restore passthrough decoder enable on region
 re-assembly
Message-ID: <amxmOj19GEh95sut@MWDK4CY14F>
References: <20260727103743.63343-1-icheng@nvidia.com>
 <d96567c3-df6f-4008-9678-c4fed3787309@intel.com>
 <amgQUnkQ1VjyXtzx@MWDK4CY14F>
 <amgqJDkOyyzMau2R@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amgqJDkOyyzMau2R@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: TP0P295CA0008.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::20) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ2PR12MB7941:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b6a7594-982d-4675-e440-08deeee3fe38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|4143699003|3023799007|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	VirBAtHfROXMDI5RYdL2A2AXjTOoHSgxeYOrnqzKdWekUOcmVP06QnCoQ+9JfP5+tgJgr/ZmfbA47DxF7OBreolx5wpxZDeefaZ+PXQwQe3dIZ8EmORfanuLURsnN76qoE16Mwh1cd8WRxSssapkbgFuswTvUn3dFs4D2O0TpU2k73ZSZRiWh1eGukDg5Knuxj6AS4SmEaOSjXVzaDePyy7mbG2RToO4uGYKSXb5iyOIFiSLM6meB74+BL2Lm7I2We+/3ovceVIuwvaoJWzb307SA4r61lAlKUtsEjuDby9eA0Dv//k3GvR9K0HUobHMlfOUcNJkBo8GzxxonR11l3J7tnWFeRBkaRoXjE29Sj7nLhT+/nQG+tTwOvdAIBk0Ksh3o1uLWgKGm8YMOhtmLhhg7rk+9ac6wON2Dblsxug7oUHgy/0kq5KLsndwK4v2vHYu2qJqJMsY7IMK1O8NA8T+JZKX5NJqu9HbVqFisfp+8Y1MMMy4EoqHIE2AJmdB3Y4RV/j83MQuYjiYU/OoFVau0y+8eh/hTDCQnUM3pL7lP/qdcghphUQtfDyw9Fha/JOPHl0o4WoO4tZH2u8AflJPFxlrJff3mE2hetY5t4UnZ33zIl+tQCLlvpmAxQ1A8Y7EE76fE3Z6Fo9PVImJhUzp6AZoqU/zCxPMWANhTkM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(4143699003)(3023799007)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VlPnpVz5WF9EQuCPCVtxgReBQFF9D+NtUcU2EfJiVJdBfkEkWKJFTHHYyvVM?=
 =?us-ascii?Q?eIVFi7/Ad46lRms/A8r4w2J0PdhpZE+DGuuSZa1JYU4fzsAPXi6kW3KPwu2i?=
 =?us-ascii?Q?dvH0QiAsNx0P49WshfDxlu30wxX31iWcUdcje+nNq8peW5Rov5tBTpl15P8Z?=
 =?us-ascii?Q?VIK1B7Ms7OBSUXqUJUPoeI9KoIbYyRmcGxvHRQ1Qlopf4Bjb6Vip9VB8bv8h?=
 =?us-ascii?Q?suLn0qQNxR0imSGjKRKrOqidvCxXhmXUFUNPzNvZeva7nkfINY1I9OL446vr?=
 =?us-ascii?Q?XXdZwIe5idXc3uTgf2Tkae8at5uAEtKKe3ryIYF6rCyx+NFWQ5JV73vKqEfo?=
 =?us-ascii?Q?yy+clbwOWBfX+sG1nuy6lpey18j9Jz31vxGOuhdyz8zHf7ySpO9rwnCWenLa?=
 =?us-ascii?Q?JZygkVgj9lCOb2w749XyAFaYhgvpF9/gkO17FA6dDKV9dZ3lIogW/kukRls6?=
 =?us-ascii?Q?Zyi60Sxgd0fg5eP3Zd//gVDVxRHmF5tTmzhr2df8NO7+ndtiBJPPG6IxHZmR?=
 =?us-ascii?Q?MTsGib5AaKu2gHbWkX0Qz9iVSrZdfb/5YRH8Xfeu0xpnW1wBWAZOHVOw2QLi?=
 =?us-ascii?Q?AepnHUIEVVtTKySTHIQc+KhrUX8BeQVYZ2uDMU7T+V5BwS8XwhXrrblglV14?=
 =?us-ascii?Q?lRh9sin47mIYgCgWa2m0N5AXeDzgN9eEXaaCNX4OM2zJxWr04SeFA4heiPKS?=
 =?us-ascii?Q?5Ijb0ZQqb5nHamWb9QxKIxRX/krb5WnUTvMDN1SiJOT59PCp3010m1D4311y?=
 =?us-ascii?Q?AWjUT/dg2QQqqTwIsl/1uUxGcjAAEtKtCAMLOmWlDDY/1Yr2UuJ/RzY59pjZ?=
 =?us-ascii?Q?2bTL1tLlR/16GG+tGelRI86t0xlqgbqLyufk4mDf8WcPiBdxGhZtTtTMLLuL?=
 =?us-ascii?Q?d4O7GVMiADdOzqxjXUYKsPUx1wRbmOBkgzd7tj2N82Z2LmyX83nM99UPXQVb?=
 =?us-ascii?Q?cA1d2ejeAqBb02cGcBpDnwjCA46Pyv6s1Omo3HCcwNfTzjVsl8qTrEoMnEh+?=
 =?us-ascii?Q?4VPZEhAdm6vvhLe4D6qivscVQpLFJdBtq3TFFWI4XohakheIu9qbnpcdKwl+?=
 =?us-ascii?Q?hDEGKumkghn4LthfRXz1qpvSQ0stQAoDiRbNrF9e3xFzH1aZFVJDoyDT/Khu?=
 =?us-ascii?Q?Yvyyy0ix4qfHaxvr04otJ844HaazGOlmTfXmVqrytSTLus/UrsrEbcxl5kar?=
 =?us-ascii?Q?JOY1myHKwYQxCoNvcuij63E+8tkbX+08rwDLqggdyWXTwIefrpzFahowNrmr?=
 =?us-ascii?Q?ShBeaHY4tfVtjmJlfUa05Yijta9JVVRPX+PCd1i16I18ScxNKP6M88R4zCtG?=
 =?us-ascii?Q?e2FwhOncbObjdzMJ9k9yzyrtTnQLeVLjKV3oyO4HWDx37KOXVVpeFLyPkrHG?=
 =?us-ascii?Q?/HrErAddD7EJn3SQDLDplmRtLqCINvzeW3gJykUJjcc8XccJZvus2j+3zAlm?=
 =?us-ascii?Q?eiYylj9isw1f3HpO/+O+LLARrEvzP+PrzWwwl76CeAe8Jwtrndgpzgo53Ofv?=
 =?us-ascii?Q?YqS6akKXmDitE84nglei3va9wMUgeZbEcQz0lTodJDKjwqg0AEmmgqgEW5Zp?=
 =?us-ascii?Q?BgQx6TGr3iilBZ8PuU/uTh8OIQxc9EDzJLnj9dIoQoYVFTRL3xD2nu/1/NEa?=
 =?us-ascii?Q?auLnWhQ6KaktS0KJVg052xRfHj7Y26piqV73+15a+kwPUwW7Z5jUxsGOT+TY?=
 =?us-ascii?Q?Gx2XnrvBQ+L86WLeVYSOQ7IGfslRWycLYP3NkYX97IreRmM85vcNc4SGbPJY?=
 =?us-ascii?Q?BgGBRwv9Sw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b6a7594-982d-4675-e440-08deeee3fe38
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 09:13:32.6913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /q6dVmtfhc218wIJ1gYGGGKDPOp/V9icqcNQRSSrcW4BoeEJbSbyQGBdEWMWvk0tFFiC+6r0AHiIC/Sd0lrhBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7941

On Tue, Jul 28, 2026 at 12:14:18AM +0800, Gregory Price wrote:
> On Tue, Jul 28, 2026 at 11:03:37AM +0800, Richard Cheng wrote:
> > On Mon, Jul 27, 2026 at 01:25:48PM +0800, Dave Jiang wrote:
> > 
> > I think this part is talking about physical remove/insert ? sorry maybe I commit message was too vague about the scenario.
> > The case here is a SW-only teardown via sysfs, this is what I did.
> > 
> > """
> > $ echo 1 > /sys/bus/pci/devices/$BDF/remove
> > $ echo 1 > /sys/bus/pci/devices/$BDF/rescan
> > """
> > 
> > No physical removal, no power cycle, no link-down, no reset. Linux drops and re-enumerates the same device, which never stopped running.
> > The endpoint HDM decoder is still committed.
> > 
> > The device is byte-identical before and after, the kernel doesn't clear it either, the decoder is locked and cxl_decoder_reset() returns
> > early for CXL_DECODER_F_LOCK before touching any register. The memory keeps decoding.
> > 
> > I don't think anything needs re-programming here? the only thing lost is kernel-side bookkeeping on the passthrough decoder, which is
> > freed with port and reallocated with F_ENABLE clear on rescan. The endpoint recovers its state from HW.
> > The passthrough decoder has no HW to recover from, that asymmetry is the bug.
> > 
> 
> Being a passthrough decoder is just a special state of a switch decoder,
> it doesn't necessarily imply programmability (Enable, Commit, Lock all
> technically still apply, it's just ambiguous what they should be).
> 
> Wonder if we're just not setting these intermediate decoders up sanely.
> 
> If the endpoint is locked / not reprogrammable (commit / lock) on the
> first go around, maybe the intermediate decoders should be force-locked
> and not have F_ENABLE cleared on teardown?  It's not like this actually
> changes anything on the hardware, it's just bookkeeping.
>

Agree on this part, I think what you are suggesting is a better approach
than what I posted, if the EP is locked an not reprogrammable, the intermediate
decoder describing that path has no business begin torn down either.

It also lines up with Dave's question about checking the EP decoder's lock state
before proceeding.

 
> (although i will say it's been a bit since i looked at the flag state
> machine here, so i could be misremembering what the rules around ENABLE
> are i this context).
> 
> Curious - what happens if you fully unload cxl_pci between
> remove/rescan?
> 

Good qeustion, I'll test that as soon as possible before I sent v2.

Thanks for the pointer !

Best regards,
Richard Cheng.

> ~Gregory
