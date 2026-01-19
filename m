Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6862280330;
	Mon, 19 Jan 2026 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768838638; cv=fail; b=Hs8/IC2hBx61k1h3OupozXsJA8dXDhYcLWIaUsuZrcbHT3/2IbAQIwtpf6od8byThKCAXDoO9M9iNCOJKcKBgneCdSZiyXyNGwKncOnJXXrk6ytZ8laCuNVytK49KI51+3xaDIp9tcQPjYAOZfT8y/FMMs7EHQ+i4FLtC06U88Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768838638; c=relaxed/simple;
	bh=yEKPpmKORhCjaiQDGRk/ipnNjB2YfbhCVHrYhWOwOqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=q/TcsvSumLFTPFLEDzbwRb+oAHRJ4Fhg4peifoO6GWs6XEQ3f8OXX7njtVamgi1OE9a1418Vt7+KFOVI/yBWp0i9dSEmaC4p/RI+CX3EmCetbwF9c4NSK8gyVrtgcfaHi70x3lhkKHGuR+cbO2PSz6hh+HUeqi1uKINjkurfaOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jKK3CgPY; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jKK3CgPY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ai/spLioPk9weTpN9uJwq5pSkiY36hj2+nG56uSoKXMfKJVg4dScfMjaXq5M0kuppAlgz54r4ZtX2jLKRInSAzY8DtCRUwBH4rgLb46ONTB/IZ7aIOdJQTAxG6VaHj1iQzKhSfM3kVpMYJG1TyfXHZWhCFUKV4Rivn1hfvAz6i6qZcHCF8dTK2E0SJllg8g8r+g7N2jsw4JFLlz35kJ/rS4mCgJsaZVWIKzCX82GDNkkWAv6MjJoLNC2mELdEqnhed5ShPkzoabpbCABcdRS8GJLWSyoF+6MLXHrrO0ioJ5aOQRJfsmmILnQoS+Ziw8E83QLC6ZOb7KZGnQC71WnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBY69EzGuDfShU4Bhws98iRWfQpyEBTgfenkrNU8pgQ=;
 b=BFyKuVCghsI/+YmAo53NHNyR9srb3PojLAO9RXA4sWF2Xrtc9dWC+PZwL80U5RqC0zoEcRsLLl6zdG2a6+2TbAWdIM38SvXv7piRjyhv1Uiat7db53pjyRFZGo3UY6umOVLi87CfQUafU7fZjaQfE8iGNGee10/Rtz0QQOMRYHs9LC5Aj3PffDSpQsDQcVfd8g36TjayvN/5nd684gF3jM7dLSXgRuyxVYrvUNwMCE8w6F2IBW9Iyc4R0eVhBzH4d7fQj7Yr78cDRqOx7r9FA+GNK6kJybikEQgoUTAZYzc03fnoAAdso8OLbPme0ClU6AcbODrZcWVcmL5sQItsDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBY69EzGuDfShU4Bhws98iRWfQpyEBTgfenkrNU8pgQ=;
 b=jKK3CgPYsC2l3tD5AHrUr3vuyA2a2VqS4tmOG9inzTT5egYDeawjm5CM1BYsCNTTzNU9+STI/OY1aZPSNrnfmK9iGcGiV8vNlP8yFLfMOph8c979XCeK6SFTbxYTJFCDedHrF7MtOAp6ulYVcwGE02eAZ3FA/KcSuVRukyP8UxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 CY8PR12MB7563.namprd12.prod.outlook.com (2603:10b6:930:96::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Mon, 19 Jan 2026 16:03:53 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 16:03:53 +0000
Date: Mon, 19 Jan 2026 11:03:42 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: Robert Richter <rrichter@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>,
	Borislav Petkov <bp@alien8.de>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	John Allen <john.allen@amd.com>
Subject: Re: [PATCH v9 10/13] cxl: Enable AMD Zen5 address translation using
 ACPI PRMT
Message-ID: <20260119160342.GA659351@yaz-khff2.amd.com>
References: <20260110114705.681676-1-rrichter@amd.com>
 <20260110114705.681676-11-rrichter@amd.com>
 <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
 <aWehZwXsK1IXRNU2@rric.localdomain>
 <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
 <20260114180859.00004623@huawei.com>
 <20260115080444.GD830755@noisy.programming.kicks-ass.net>
 <CAMj1kXENYZq-UkCup6FSH_4tmpRe4xJN1_veuSWs-hxxAo=1Ew@mail.gmail.com>
 <20260116143838.GC1890602@noisy.programming.kicks-ass.net>
 <aW5AvfcjLkSP2j42@rric.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aW5AvfcjLkSP2j42@rric.localdomain>
X-ClientProxiedBy: BN1PR14CA0003.namprd14.prod.outlook.com
 (2603:10b6:408:e3::8) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|CY8PR12MB7563:EE_
X-MS-Office365-Filtering-Correlation-Id: 3662b901-25f9-4577-69c3-08de5774575a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g3rb8y558HJEAqxtbhTD5LIkeLQf9586kmC0TpaPEISChcKql4jKZzTWw4Tx?=
 =?us-ascii?Q?Yt4/7C8OvYZym15e4Q0yDUaw+bEOgqjYFsKExpT7kvFr3rJ95IpMBlaW7Cyj?=
 =?us-ascii?Q?lIv5b6enLth2KJqOBK7QDHWfmAls3J4u8GJfrxJvcaGu7nSqYH5ct23G8k19?=
 =?us-ascii?Q?PtsQqTR9gH6F4YTZZbS5GfGauQFGtZQag+6LynQlbQfuvUYbkJpGBPo2vXou?=
 =?us-ascii?Q?9YApYV3oLYce+tnchCfxD0W827f0vcCq/yj3wrunSJehset/z0J3vNMwTGTF?=
 =?us-ascii?Q?tvP8m9FYw51hdIOylNBEwXAS0siV6iaMQoJ7CVNoLQqDVk9yy052WbDCZo9D?=
 =?us-ascii?Q?FS0g77p/tvc6kXtJizUYPBOyoeHd4Oj/SXdHXAh9pqVZlXzFaILnSqp7Dvcq?=
 =?us-ascii?Q?FKe6VxveszHWwuIfJTcJR2u4LRFKM6KvY4E9HmNEfzIC1+vv6Zy+mQ5CdEvV?=
 =?us-ascii?Q?6tNSydLOnRw/SS4E9PGEUAKXvkn/hM31takzl+wJE4+4udK/3rB6GzYwVkm3?=
 =?us-ascii?Q?7x/n4++kTZ48O3U9V7udKRH8upmJRDrtrICCOCYK91TH9TGDZwDSMh7USCnc?=
 =?us-ascii?Q?wOR/JqhJxW++zI4O76dn7x4/KuhUZzHCHaPAScwwZjjUPvKR2Dyp/9LhNERz?=
 =?us-ascii?Q?eaDih3YwdO+Nk+EpvdI7P3OTvQRogZdCr6n8uadMq4chqRzylNcQXW6kOv0e?=
 =?us-ascii?Q?uQqiNBbAp387Xn6cOZY2mdv+Nggc+1oqNJe1yoiYrRtnuiyLzPeF+iMvC6av?=
 =?us-ascii?Q?9jXApXh5y3/3rFEgZCR1bh0GPy7s9CpPClW5kwJXW5cRC91gBdQi9gt1+JAh?=
 =?us-ascii?Q?9o1rn1ehgsAmjkbUG1qDZsAjfEs0SfQJTS/OienbEA/w5vQPtPgeIJoRP3mI?=
 =?us-ascii?Q?0rOocyRN/SUNUdEjeQmxaMVNkhScRs+oPgf9LxwkHgPELKsIRIUwCW1SWBIh?=
 =?us-ascii?Q?q7NuJ+j+C4oVrn3aITCAtN0qZfUN3rL0sKJ+VSBvg3s9bNNA6TZSx4lzE5mh?=
 =?us-ascii?Q?V6UV4ax07JWVaru8xYBxgcan1goHU0LNhcFTbgJNsQjsC5RwL3gtAz51SwlX?=
 =?us-ascii?Q?/puU0LvXSqeZYsHV2PoITvpQdM4fWUW3dtBFKlJY9mDS2zVvyMR9gz2mSg8r?=
 =?us-ascii?Q?obW9LQz5a+k4BXD1h729yUhcAyPtgA12t6Q47LEG0DpRrRUQZ9Qm8PfRbhzS?=
 =?us-ascii?Q?age7RT44ebDQU8vDOnvEKZv45818xyJ1BrJLN/JqemkssKCbfrsXMDN9PqmU?=
 =?us-ascii?Q?gLB1/VkZ9m0Hi2N6Vb3ypzfHML9WvUKHKwAvCxlRMCTl1VfQpHWoOd9Uqwol?=
 =?us-ascii?Q?GneUbPRIoiNYxvuyXwD9EGJ8flca4adIjpoXri8GMT0F/6G4Sy7YOy3agITG?=
 =?us-ascii?Q?czxJcZghKlJPnPE/o2o7CcxjG/aXQyb50qYl33IiY0DEhlpcaoBR9VQUKrbg?=
 =?us-ascii?Q?dZKIgINKkXAjF+SGIlwGdrZ9zvuZ0nuK2qTMEX8LVUs6Ts2w3cGdT8VKsP2q?=
 =?us-ascii?Q?F/Pb5Xks2wv0jf993eMOc+z+MtQxSH0YmhtOx/pov+duKqQWI2esjKEs3BgB?=
 =?us-ascii?Q?Vt+X4QhmI2OxbDwvuz4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9/xu/GVkr9IqAiz1FFTZ89+tC+xOLVNz+wN0ANBMsyIjpF80befFZC2kPEM2?=
 =?us-ascii?Q?GHydv+yTeVU7+JO3OnUTTQSGGDUvxts/H+leY+Kj4yrG5nVl+LeybOWYmxGH?=
 =?us-ascii?Q?W4e/fHp64KE8wzDNn/itU0h5n7ol9rcr8ErlInPLlIAl6W36g8NAU/Q2YwTt?=
 =?us-ascii?Q?tFFfionQnFtrxUiLIQGqmdEdzjxuYOW+jfsDUl8qRiJEBcCbZOdfXN9hG2VV?=
 =?us-ascii?Q?rWRXFeUO0WUcwd5x11ULplJ0+7i85TG+JlqZfhX4h/hbRHZQ6w/6ksgETUui?=
 =?us-ascii?Q?CAao1G82ZDS7wlLC+CvI/tVZ5HS9Q5IYBO6gLAmAQaTfqe7FsZ5CQBmnwcCo?=
 =?us-ascii?Q?uWVGwYiYCiOWFbJK8tHMtKFVd6wtNAKvapyOJJPv9JfJmIxF1gtT9Xwk5rp/?=
 =?us-ascii?Q?Ggo0q5pIighNq10g9dDqHzjaoWVz9cDCGA7wZWZGjkpQT5/8I7BdkO9+NXRY?=
 =?us-ascii?Q?rM/JNa8CkTi8hJewt1kCYw/LenpRKCXdXNR5a4TNbpr+2Pbeb+OZ2BxMJ4sL?=
 =?us-ascii?Q?+ZEyvaauavMOl4cUcItVVj9pyxb7ucHw+HEC6ALG/fcXuhBvffYX4/1UjU10?=
 =?us-ascii?Q?JpBeZWetn4mqSs2PPam2kV6eQM/RD+2M6q4Q0iuTl1efY+0SGGGyw+xlClzA?=
 =?us-ascii?Q?9pblUvaNPzU3/64YiColR/MbTvArLgmMXzoPn5+I/p+sXclj973aCtH/F9Dk?=
 =?us-ascii?Q?t7bOO073qCQCuziArr9HMkF7bSsAbZb5yUhmrZ+AB1No3Eg9avuSbklQnQZb?=
 =?us-ascii?Q?6fWwaHFzgb6bkNFqS4Fib6VYVSEZ+nmaBWlNwSQ37hYIGvFaEK4bCN+6TvsW?=
 =?us-ascii?Q?Am3Gc5H9uH+PqbkbO0bSiKuM8onniApksXjtSnJou/RsDJ/axNY8s1qd8D3l?=
 =?us-ascii?Q?mZvC/QuNjiEG5Nq6IfwB3plWLajEdht8ylU9QRR5BwAe5X/P2nOH2KzNrGEX?=
 =?us-ascii?Q?krCBGc4CTfaD8Liou3i0GPioSAb6tRzsEcFwVxo/0+87dTfKTke1KUfYGwI/?=
 =?us-ascii?Q?YRp04NnXSLsxeHunP1tovu04u1ia+foeZ6d8K0zSPAE+bBA2ZPd2uA78zsoz?=
 =?us-ascii?Q?MUGyJJWuXnxy8JwSVAEJ15MVrOH2h9dxrGHcBz3jiNaoJWtpvrXpCpP7WlYm?=
 =?us-ascii?Q?37dNzlhRuhLg+A8W7DYrtNlhpTa+qOpsCmXC+g9VOGvDh0Za7155F8ydUrTl?=
 =?us-ascii?Q?vX0+EAxnUMbBDFEG9iNDyt2ykmARxLCmYwHUwXXCUZbeyjms8Hzus8WCHNEJ?=
 =?us-ascii?Q?ZKWtqBrq4HPCUJVsOmc/eURc1rCDrOsB+jTcYNvyzzsc3LgR8QEexpKwUxkK?=
 =?us-ascii?Q?hpxwtDNnIIxn99fV+GQVwPgSVTvutfR2cc/4Ljv9fKyaF1ztyiIcP40wrUIJ?=
 =?us-ascii?Q?fTpb7mm/uR7cNZn2b5dxItFrp/4RpVCUr8ESyKyEmodQ7E4Y3DGXQYfMhvJw?=
 =?us-ascii?Q?hmQvEBsAVR03V6tuDbChDtvCBK9le5TdvePzWN11yyOVdyv2cAitD1X1baV/?=
 =?us-ascii?Q?aaNmJ9AkCCHTuIw82Fw91VJ7Sces9gVxt9v1pDFzyQxIY2hR58mqEt/Sok1Z?=
 =?us-ascii?Q?3wPeR5YSSmMnAg1eaV86N9OHmdaGc7EK8QRYTxzXkvL7ULwsxOx0G5X2Le4/?=
 =?us-ascii?Q?HXOepcHlcY+gpDxykulFQB80HlWYvUyZBNDG8KJNMLjQZK8PPVywpVO6Eoh3?=
 =?us-ascii?Q?6Rc42TiPQsBbs0sRC4snAwfwv33MN5mX57qP1fJ2NoNKTbBa6MF6R0WtX1zi?=
 =?us-ascii?Q?9kq4D1mQAw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3662b901-25f9-4577-69c3-08de5774575a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 16:03:53.0307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MyKYaUtSBzkIp380qJfz6kv/MjHp9h11DPK3TzeWNx1sgFDu2NWWVD+/Azk1MtVqhiTiiKBlX3MuiBauzp9XRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7563

On Mon, Jan 19, 2026 at 03:33:33PM +0100, Robert Richter wrote:
> (+Rafael and some AMD folks)
> 
> Hi Peter,
> 
> On Fri, Jan 16, 2026 at 03:38:38PM +0100, Peter Zijlstra wrote:
> > On Thu, Jan 15, 2026 at 09:30:10AM +0100, Ard Biesheuvel wrote:
> > > On Thu, 15 Jan 2026 at 09:04, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > On Wed, Jan 14, 2026 at 06:08:59PM +0000, Jonathan Cameron wrote:
> > > >
> > > > > Do we have a potential issue wrt to merging this as it stands and improving
> > > > > on it later?  i.e. Is this a blocking issue for this patch set?
> > > >
> > > > Well, why do you *have* to use PRMT at all? And this is a serious
> > > > question; PRMT is basically injecting unaudited magic code into the
> > > > kernel, and that is a security risk.
> > > >
> > > > Worse, in order to run this shit, we have to lower or disable various
> > > > security measures.
> > > >
> > > 
> > > Only if we decide to keep running it privileged, which the PRM spec no
> > > longer requires (as you have confirmed yourself when we last discussed
> > > this, right?)
> > 
> > Indeed. But those very constraints also make me wonder why we would ever
> > bother with PRM at all, and not simply require a native driver. Then you
> > actually *know* what the thing does and can debug/fix it without having
> > to rely on BIOS updates and whatnot.
> 
> an address translation driver needs the configuration data from the
> Data Fabric, which is only known to firmware but not to the kernel.
> Other ways would be necessary to expose and calculate that data, if it
> is even feasible to make this information available.
> 
> So using PRM looks reasonable to me as this abstracts the logic and
> data behind a method, same as doing a library call. Of course, you
> don't want to trust that, but that could be addressed running it
> unprivileged.
> 

Additionally, the same translation code can be used in multiple places
(tools, FW, kernel, etc.). Most consumers treat the code like a library
that they include. It's coded once and bugs can be fixed in one place.

However, with a native kernel driver, we have to re-write everything to
match coding style, licensing, etc.

Also, new hardware may need changes to the code (sometimes major). So
there's upstream work, backporting (more testing), and so on.

See the AMD Address Translation Library at drivers/ras/amd/atl/.

> > Worse, you might have to deal with various incompatible buggy PRM
> > versions because BIOS :/
> 
> The address translation functions are straight forward. I haven't
> experienced any issues here. If there would be any, this will be
> solvable, e.g. by requiring a specific minimum version or uuid to run
> PRM.
> 

This is a good point, and I've brought this up with some of my
colleagues.

The PRM methods are supposed to be able to be updated at runtime by the
OS. We could think of this as a similar flow to microcode.

Thanks,
Yazen
