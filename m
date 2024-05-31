Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2134.outbound.protection.outlook.com [40.107.243.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D347315887C
	for <linux-cxl@vger.kernel.org>; Fri, 31 May 2024 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170647; cv=fail; b=EAi5Cf7mIABFiArFpUwy5rKfU9UjlkFFB+R98Fri31wPAzwqqfmQYuXPQ+M+/NRPmDTkMMOeColC2eUKLaqKMs+ku+grCPnXIJh98cmxzK/Bp2X6PD3CO00QGg/eXvr0L1GzVtcIk6Z5/wiRdKEiylAj4HZxNa7I3VGhnY2xzqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170647; c=relaxed/simple;
	bh=/xns4wWty767dPKlJtVzbCvACGb+4aFUbv3a3MTxeLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EJcp87/etaCb8dTnjZjQRMq5hIcOMfr1mIjIogc7pj8hJmXHRKAJ4zT9rnqiII9Sqhxoxhg2zNSo8+AMpAJFWtQfmGE0Vg3f82QeGq036Tw1dE/Z7VsfQjK97JKnHsO5hxcE2gWaOX6qoNrqW7anCeQsVc69dBO4AqO2eT0MMYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=oZEGNfU0; arc=fail smtp.client-ip=40.107.243.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="oZEGNfU0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KU2aklGyycL3Y0B7hqoDH03HC0H48FT28HZj3Ydt+XMsWh3I81S/BhHNj6X8Emg/SrHtyqODJ8+xMVGEnApaWPKVyr8UCR1m//5YjgusmNxhUxTt2fUmDCugCtVilcjFVt7b522jpegg4OWCfTZtfU9t+SlxOI+qOf/ZiJglasezLrJGUkpEHC88cqa2nIs8ZKIoFhzT82E9lyNGUYbdtTXy2xycldfGcPkZYo+ny5+WKzWNFtTAiv0Ah+y6K/lbAF4F6Bpxj6D+zc872/d6h2zeys13GC5yfcAOKWmEU6V5GJwzC0f1N4OphlJZ1wsN6nFLp1lUG0ikL45nquJbPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iUdCFOLeMRRxpbqkp2ffR9Le34DlEGr1QPEs4oS/r8=;
 b=bJjtaYW0UQ33VS0RYUcSnlbBMyTlewYZiJf4PiuUmuwWk+UDHL3G5uZjK4xlaJDP2ZITwhx4ExGnHdftYqsouWwtdiJw6jsjXDHSDSWWPDyKUTJ4IU+dkWFqEmBV5CA2yUvEh2IlZJc0Kbcjgy2ggTj88AXskjq6sPowrccIT4HfdOZ9AT8+Q19zUa3hlFzsPKwRTwVsZVj+WasrC9aTZwN+UxiWkd3tHAvPJS6SlTbz0lIZYRhLCY9BRVQCpK/Fl2K9HarAnQ9gpGY/al1hmP1uLORWIQDxo6yY4QnEFkbUdmVcZ9CDDAxVjR+IbdYirAU5XGD8VtOdAt8rpRw3hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iUdCFOLeMRRxpbqkp2ffR9Le34DlEGr1QPEs4oS/r8=;
 b=oZEGNfU0H5RkSEf2rxXXXalfE0CO/ngzavQezCk3rHiOomhvT7Z6t95UU5CAmJ6jeoyz1H2BCvZ9OkRXpl5wQ9vqWUcqabvZJIEGaboQ4lhAQ8pOhy8kR2BQTIqikS1sqJVYioTf9E93wCXNuV9MiuFHk/TdbzJgNl5PDHlohvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA6PR17MB7228.namprd17.prod.outlook.com (2603:10b6:806:41c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Fri, 31 May
 2024 15:50:42 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::5d53:b947:4cab:2cc8%5]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 15:50:42 +0000
Date: Fri, 31 May 2024 11:50:35 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
Cc: lizhijian@fujitsu.com, dan.j.williams@intel.com,
	linux-cxl@vger.kernel.org, y-goto@fujitsu.com,
	Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
	fan.ni@samsung.com
Subject: Re: CXL volatile memory: How to restore the previous
 region/Interleave set
Message-ID: <Zlnxy5JnBjREhH+L@memverge.com>
References: <36106fcf-1062-4961-8918-4471fd313a74@fujitsu.com>
 <6656801ef0dea_1668729484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <TYWPR01MB10082738078CF843AF514F7E790F22@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <ZldaiYTv1fPcGbCs@memverge.com>
 <ZlhWXu6l6i2nYL+t@phytium.com.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlhWXu6l6i2nYL+t@phytium.com.cn>
X-ClientProxiedBy: BYAPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:74::15) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA6PR17MB7228:EE_
X-MS-Office365-Filtering-Correlation-Id: 8925dd9a-30e6-47f9-89ce-08dc81896d3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?piAV1enkvLnv/XqnW3uThDNnLctFzWbknQGepYx3906O+MIBDSjoRLjA8z9t?=
 =?us-ascii?Q?4wXcmq2b7JoS69JpikD3eacu8PHO/DqM6GAcHvpx1CGC0TwI+nZCcKuK3AOg?=
 =?us-ascii?Q?J79D5SPV5Jk78H4avYzNeegYfY4OJy9KJyodb62myB9NLgm+VhHBuWdwgq5U?=
 =?us-ascii?Q?kx9ggxqI+aBBMOFIuP2it+pEULbRy8w51P9EQxzWMgpw3n89RWAcvC8qI/dc?=
 =?us-ascii?Q?grgL1hWFN5a1TlYCuEYAtXVH6uAoptyBRKs6VQ7YAn9goLAAqnEIANd5CAkd?=
 =?us-ascii?Q?PyJ2SN8kAEIsYevu71TdgOhbf/WsEmNwhLIkUw3x0bXIGde7TTAWpkd35oZP?=
 =?us-ascii?Q?I5FBKgm0zCVu1Igvo9xa2phfDpY/brF44wabDuLmVjWwLFEPiKef9Gwg7cOq?=
 =?us-ascii?Q?GqZRYNLEvps3Vd7M9mQh2TuYluN5Mu0LRv7h3lsRwdToBc1qmDHD+DlOxnwn?=
 =?us-ascii?Q?P2yCqzs4BAlxOHpQgxU3ZSEQ/VGN2wItQhH3APvKXayplvK3KcBbbiYIwGl9?=
 =?us-ascii?Q?S38gxHo/TSFjQHqBcFeze5ZsKYAiP2TL/ltNXKmVI84excV5Ls3TKEyjMvQQ?=
 =?us-ascii?Q?IRt4edAffPKV2KpmhL+EMAXCHaTeP1chAxZfRlAp2tRLkipsG1ZMmgvRAjp6?=
 =?us-ascii?Q?e4JsFOaAUEcnTaTj53g24v9duKyrVlIRbtcFeqVx56u8KDwTtt/NJcxhX1N7?=
 =?us-ascii?Q?7Qs2mOZPSHS0bNHVvfYZcao4im2WVxBtbXQtXt8y3FHhhbUBUfOPgnpodiP8?=
 =?us-ascii?Q?wb06d5plKrHXM32X72nTQ3vrirpC6G6KthgSPOsryZ9icujegsbG0+THNbcJ?=
 =?us-ascii?Q?biG9dwXUIXirGrmcqhsaJPequ2i/EDRF4bK7TecU/YRv+ZswZsh+ap9y7ZEX?=
 =?us-ascii?Q?0XuoRp5Guv7EaQS70SRrRqtpXt41aAQeNRnKYoiXuaTD9bqqMOR47Z6RdAKV?=
 =?us-ascii?Q?fGO1qbQ+tHQ/K61H/b5K5UoLQbxTyaETv66u7xc2WVh+6zSR3gs5rPPjIOrO?=
 =?us-ascii?Q?Aoxxwgeji7pCaqKz4wQmuwTfNvm+R9arM9ezxNXxbMPGY82I0dYkbqLIZj4I?=
 =?us-ascii?Q?2o4zEi/dDpzO9Zh/f/heB4YdRq1nEjNxjrL0jWoSAAy4WU0KXYYz4L0s03H3?=
 =?us-ascii?Q?ajZesf/3iu2l3rxC3keIBm0Mgj/EanWDTyZ3wEfkEhK0P4yGDqgNGOPXSeF1?=
 =?us-ascii?Q?fitMieKFVxd/7jZXeZnIFF6kXOPbKz8b3PRI7zWeIXI2JRoLCXGqWcXLkdEm?=
 =?us-ascii?Q?9AxCOGqz2zO1E6yZr7UGhXlZ48p+AgWPl2Kuts7SiA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4MrVDnvevYDc9nKsGaKaz7KrZKFW0HBHv6jvVUhHsIgU47+8t1IdRlvVIYEK?=
 =?us-ascii?Q?RrxsyGjFu4ZKyCo61iH6sZH3MtyNeKSHyma1hrqSZQaR8ibfCMKq7pWdnQh+?=
 =?us-ascii?Q?r0soGGB76fIbaW7OaVgDSCzi4A6f/h4/bfX/vWTDPXLUFLZIBD1hpgDOEhz3?=
 =?us-ascii?Q?YkXgw3f1UaXIn6w+JlKpQw6I+jkT8dmO8O7XXz3oW0zO0qZw/6ec6Qa0qyHB?=
 =?us-ascii?Q?J+jB60N1Gy3rEGeHtYSitdbdP7CN6C6Mlvcs1K5KZwp/dxT+Hdrov4M0hEJH?=
 =?us-ascii?Q?1WiahQKGY6J6puwtPiAEJniD1T+uc733xtSpL3YK8g6bnRWsPCo8M5KTIOQ4?=
 =?us-ascii?Q?i3YLlEcH6jkQ24jUoaMzlasazozi7veCCNlQYysOTLfTv/0IoEE/2tOBUxZX?=
 =?us-ascii?Q?/KUM5r1/gWUflJJC2jhc1SdCwNX6RJhYeRj3vppe6HcX25Tje+T1xr5AvUqf?=
 =?us-ascii?Q?eKy2bWYpEZL8OLR1LD7SijCjcmLSzWnKBXPmmppZMwegj/5dhEWnJw9xcTbf?=
 =?us-ascii?Q?YZTGUchoG+SktIxmn1tdMAK73fq2LrDyL9Rf2BzXOLqEBcBTzVsYAK2Tac5C?=
 =?us-ascii?Q?OqK3bY461GbGMUFblBpZXVAJFj8xe1ZlRhX5+74ZmQOjhMQoBLjL/12wE0/q?=
 =?us-ascii?Q?+nrByRGoGX4SC1c1FrHC6rQLS9SrA/YAo7+8haSGPP/uIzVD1/YUt7CJHLr9?=
 =?us-ascii?Q?z23VZ+q/GSCC3Ah433GDFA68cffm0z3bgVRtWDQcycekIwFzE3Lpy7oGO2ZP?=
 =?us-ascii?Q?bmqsQfj91nuy7a9aB+fhT5s6YnFamfu0U/VgOd4CHFT9fvDfsXYhNAsGiiG5?=
 =?us-ascii?Q?E76ifAZ+xTB49x5GFXcJ72CDyDr3sYMlOdOMutUNbY9iKABnzKgemN2Dk2nX?=
 =?us-ascii?Q?LuR0yLpfmPX5LX74g8bBS7a6PtiIUoYhyX8R7680WeZN287ZNMPqeVS+/gpf?=
 =?us-ascii?Q?TEjH0g5knU8hbIhABe487z+hfPxA8rah/3lejfZMQUO38bjZYqW4Po6OvnWo?=
 =?us-ascii?Q?rjjTwkg4xrl+XJfLpexZv9LIeUQO8iPleb/dRIXXHtgixQYaAKhC69k9Y9I0?=
 =?us-ascii?Q?tCUdgkUR+r0gthPaUocE19zzfpGEcP5cA76d5mq2bO6a/lyS+noUeKCC2bBA?=
 =?us-ascii?Q?lkyBYBB60n8nJN1k5O3PQeZ+yd9rbtcXIi6wfm6Yyt7y6kYnIlkHgrwl8blH?=
 =?us-ascii?Q?72UIxDtXxCCmHG10sk+209CqajhH2H24zTYk/MiLNWnlgdk4zO9fIQBfkB3o?=
 =?us-ascii?Q?tee4UWvOIKFh+bE5JvUQAiO6B06OB0s+j0+0YpS28+XZqQlKStiLdgzaRIPk?=
 =?us-ascii?Q?P0Km8/aNoybNmdaTDe0hdrZ5qpwhXXcPpsDdv5Cr7aKvtSCJOQBFmhQLdhgU?=
 =?us-ascii?Q?pOXM8DMCukQD+4/mxcyOzgdI4eGDT8FJsgJZ83w6gCxRWhfZNcRQD8ffqIpg?=
 =?us-ascii?Q?pfG0NxDpK62yAzXHOLKx53I83nadsoyJ/YOYW1RvblbO6N2K3LgGJAOwLPTe?=
 =?us-ascii?Q?AjeNVfuLzNylSZGRI303JdanSz30AvHVLb70J1wX2WRxnr+4FcPySZx6TcNi?=
 =?us-ascii?Q?7f3EM96iguf2BifykjQ1MTaPK3nsR1UE2dZbyUdaIjbKrPNFwuyWD8v6JUQ6?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8925dd9a-30e6-47f9-89ce-08dc81896d3e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 15:50:42.4897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4nWwl3+zRoldaE/fgS1GRkEajNSFUiO9FSwEkFQNrv0QLeNz81iTuXIPtxdqC1qmeH/0aXBdH/qO1GyyAnRGViZbYJOMH34W8FaiIa3cEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR17MB7228

On Thu, May 30, 2024 at 06:35:10PM +0800, Yuquan Wang wrote:
> On Wed, May 29, 2024 at 12:40:41PM -0400, Gregory Price wrote:
> > 
> > The CFMWS is the BIOS/EFI's mechanism to report the system configuration
> > to the Operating System, not the Operating System's mechanism to change
> > system configurations (such as interleave).  What you're talking about
> > is re-configuring HDM Decoders to interleave devices *presented by* the
> > CFMWS to the operating system.
> > 
> > Confusing, I know. But stick with me.
> > 
> > 
> > 
> > The interleave referred to the CFMWS is the BIOS/EFI telling the system
> > that memory accesses to this (physicall address) region will be interleaved
> > across the set of devices that are backing that region. The operating system
> > is responsible for reading these settings and presenting the memory to the
> > system accordingly.
> > 
> > The BIOS for example could configure all devices behind a single CFMW as
> > a "Single Device" that interleaves many physical devices, and the OS should
> > present it as such.  In this scenario, there is no need to configure an
> > interleave region via cxl-cli - the BIOS already did that for you and
> > presented all these devices as a single device.  All you need to do is
> > online the memory.
> > 
>
> Sorry Gregory, here I have a question. According to your description, the 
> bios drivers could prepare some interleave cxl region configurations on 
> default cxl hardware(SoC) just like we using ndctl-tools in OS run-time
> (cxl create-region). 
> 

Not in the sense of using cxl-cli or ndctl, but in the sense that
BIOS/EFI is responsible for reading hardware configurations and
presenting a sane configuration/memory map to the operating system.

It is technically possible, though not necessarily implemented anywhere, 
for BIOS to read the ACPI information from the devices and program
the root complex/decoders/whathaveyou to present those devices as a
single device to the operating system.

The BIOS reads in the ACPI0016 data, generates one or more CFMWS/entries
and hands off management of that CFMWS to the OS. In doing so, it's
perfectly capable of programming the CFMWS to present multiple devices
(or even specific regions in those devices) as part of a single CFMW.

This would look like reporting a single CFMWS covering multiple discrete
physical memory devices.  This CFMWS would have interleaves ways set
to >=2 and a TargetList with multiple discrete devices, with a single
hardware physical address region that applies to both.

The operating system would then manage this region as single device.

Looking briefly at the CXL* Type 3 Memory Device Software Guide from
Intel (July 2021, Rev 1.0), this is described in section 2.6 and seems
reasonably straightforward to me.

You certainly COULD save this setup in the LSA if you wanted to, but to
put bluntly - there's now a better way of doing/managing all of this.
HDM decoders let the OS set this all up.

And really the LSA is meant to store information about how to stitch
persistent data back together. This is probably why the LSA is not
referenced for the volatile setups in the Software Guide.

The LSA in the persistent setups is needed to ensure the data is put
back together correctly (you could pull out the devices and swap the
slots they're in, for example).  This doesn't matter for volatile
devices, so the programming can be decided on the fly.

By my read - there's somewhat of an implied "We expect your hardware
environment won't change much, so a couple BIOS/EFI flags could be
set and forgotten about when setting up hardware interleave" not
written in this document.



Side note:
I believe Intel did something similar (but different!) recently where
they were presenting DRAM+CXL as a single NUMA node as a function of
BIOS programming. I don't know whether this was done via the CFMWS
or some other tomfoolery, but it's a similar concept.



(The following I'm still a little fuzzy on, but this is my best
understanding of how we got to where we are. Iif someone sees
innaccuracies, please slap my wrist and tell me to stfu)


HDM decoders provide the OS the capability to decide how to route host
physical addresses down to the devices with the ability to program the
root complex/host bridges, switches, and the devices to configure
hardware interleave after boot.

In this scenario, BIOS/EFI would report a single CFMWS to the OS for
each discrete piece of hardware, and the Operating System would then
program the HDM decoders on the host bridge(s)/switch and the devices
to implement the interleave in hardware.

This is the `cxl create-region ... ways=X devN devM ...` command

In some ways you can think of the CFMWS way of interleave a kind of...
"Legacy Pattern", because probably just about everyone will eventually
want to use the HDM pattern because it will be capable of supporting
things like hotplug in a more maintainable manner (or at all).

For example - it's harder (if even possible) to tear down a CFMWS
implemented interleave pattern without rebooting the system than it
is to tear down an HDM implemented interleave pattern.


You might, however, want to use a combination of these two strategies.

If, for example, you have 8 expanders behind a switch attached to a
single host bridge.  You might want to treat that as a single,
concrete device - as opposed to 8 separate expanders which the OS has
to manage. Doing that via the CFMWS lets BIOS/Firmware simplify the
management of the devices and forego the need for specific driver
support (at the expense of flexibility of management after boot).

In that case, you'd have the ACPI tables and firmware hardcode the
interleave and simply present the larger pool to the BIOS as a single
chunk of large capacity to the OS.

Or maybe you might want to have some of them interleaved, and others
managed by the host. Software defined memory is fuuuuun! :D


The specification doesn't really have an opinion on how you "should" do
all of this - it just provides at least 3 or 4 different ways to trim
the chia pet and lets you be confused by the mess it has made.

But as for the LSA and volatile regions, I still don't see a compelling
reason for needing it to store prior settings.  That seems more of a
BIOS/EFI feature that needs to be programmed.

~Gregory

(P.S. I was not and am not in any way responsible or involved with
writing the spec, so I will now happily take my beatings should I
have gotten any of this horribly wrong.  This is all just my best
understanding from having bashed my face against the spec the past 2
years or so).

