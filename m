Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ADBF23DEB6
	for <linux-cxl@vger.kernel.org>; Tue, 10 Dec 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733838037; cv=fail; b=PpiiVhviJvA0ESl52SZSo44UBYEbGpHGpOFQ4BEthwmWPnAN+WtJ7eg3RWsArEWkCIwKSWkmIFit3IHnRsoA0PePCO0U0fc1B8M1aOR7P+EBOjM5i66+AsCUWSwmpwC11tEhU/a32wiG6BaNc7ivb7tN6ahhq8tYszKCyUNK/a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733838037; c=relaxed/simple;
	bh=1CV+9xho7iVQhQ9ARYxUXH0IGYVrjfLT6TrKcljgC7M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jqHx0jyWXoUqWSrI4r6s7z4r6Y380Co7KNUDWnZgtCc+JK0MnrOg5pYbc0uCzO9UZTF4VmyQx/TIf6TD4Gj4OBreDilZYAHOBXCitA4wQRKmlUgCU0ciCDVsA43elTEhCnhnIcRU7mtv6lZ8G4TwigtG3YGfhHPN+IvUTerXkX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iXE80Vld; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iXE80Vld"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XOiz0+9ttNVReG+JRdiSQj2z4/lnzKvzN2MIOEnAZ7M6DCZQvsFnLaRnsTzRo7+dsj3l8AYl8GPijz156ZlUf8JzrkkMPnWKV2yjXyGlGN5+/60Afynfyu2CR2LPugpv9JqutGygpqWsBLTUtNVt+1T+auwOGhys/M5QlygMFBXb+Uux46vMgztTQHyF6rV4SfYwb/o2fblM421SHy2UO1WcZuk6faICA61FzKJ4/TNGYacOUYFxBNezsBS7GF5fy0AqNqlulRCz5BzYFTlEnAIVqYHxzV1249B24DyO50ymETUJgQmiN0Ke6BIAqYnCjX1PnZ7NkXa/xpoF3r7Olw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMLA8Ldgsh2jARylk50aOQ437QGDokRLEB7yJ54keu8=;
 b=Dt07kW7JfJNNW/oY1Fh2KKhZUHkm87AOo5dNQWLkrJGjsdWHgRvEd7yCXQ/vKDcrQNstDaR7eza7/8cyzbSkB7jDuF+UtrB5E32utmh2RxGqxfnc3H4KCa/pWRXNjO5wwyEeR/+MlgTdhDCW0Z+9uw1rGB23iBS4m7A9jGFm3oAD6iSzsRJlB2jfUBAv1d0G0rWcHhwvx83FvAaP7cvAggSIRZB79OC+KGugiNJmOSkw54X5JVWB+iiRUgXcRb91dsMuj3VHFEjF1t7E8WI4xmCb/LdmYF7qbGRpvW/zDA7YJG5f5F4ad0CuKLK0pTWdmP6Ub1ewWTaMz+MsL/I6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PMLA8Ldgsh2jARylk50aOQ437QGDokRLEB7yJ54keu8=;
 b=iXE80VldCqLBp0zrd3Wqud3a/dNayIcuV2QNM3OyVPD00wiL1StvwaPEwFx36Y2V26KoSwLvgRqvEkcvwX8qFvxH6wUn63GeyYiXx/4ZUM9v0Vs2u8Q1NGf9Pnw2o+z4eJo597cjW5qY9GEg/68IA7t1kFkndprqgeJ+9pNgkqzinAtmMuVbxL+wNaQ3BTfhEexsM2kCzHo8h0QZBaV9MJeY3W5ZH7pXtovkWevI2Ipz1PtAFRztDSuOzhX0x/DIhJVmL44f8vWe5megwJ57yX4dw0Zc1qLLXRH5++FjaiTfSTeLYCeaTfxaxA7Ul+B1WHEUQho4iv4GgTXr450SUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 13:40:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%5]) with mapi id 15.20.8230.010; Tue, 10 Dec 2024
 13:40:32 +0000
Date: Tue, 10 Dec 2024 09:40:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [RFC PATCH v2 09/20] fwctl/cxl: Add driver for CXL mailbox for
 handling CXL features commands
Message-ID: <20241210134031.GF2347147@nvidia.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-10-dave.jiang@intel.com>
 <675251891af76_250732949@dwillia2-xfh.jf.intel.com.notmuch>
 <20241209133053.GA2347147@nvidia.com>
 <67575482962f5_10a08329434@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67575482962f5_10a08329434@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: MN2PR08CA0008.namprd08.prod.outlook.com
 (2603:10b6:208:239::13) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: cda8f328-9a55-473d-77eb-08dd192037f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9IaIhPK56RA0LXfNA4lmpfYrZtDVN1IXguREb5z1Ln+XLnWJ4GPfK3Qluz0F?=
 =?us-ascii?Q?piJvTvgiGBUqEm+xn/n4nE1+pKzj2kGlKi0kKlhO3NkZXvM/usFF3PfQD8Ea?=
 =?us-ascii?Q?+hQefravCa2yIN6wAryIzG4rySDuH8C66gOfOOk4fMfFgoQMoa70ej3eNStn?=
 =?us-ascii?Q?LFknFf2ZNMWUdpVJiiXGCNMh6ClJX0p00ZJ/b7OweUzRkm8KxqQU42h+2mMd?=
 =?us-ascii?Q?P7VnwTVGUBHdT5xbxWA06+tcFpoDZfPoQ75EqSHfGI6ZX/7W87x43fvIilXa?=
 =?us-ascii?Q?aXnurXeHQbXVfmDphvkZbokYN429XMCQC5XEDWTWoqN4V8Re9hZttD630GPR?=
 =?us-ascii?Q?ya5ye3PSVMjCjdtSs3A7pnnxfao1rGjhBzxeMIOoE32X8dvOvAeNqAT3v9/d?=
 =?us-ascii?Q?5k2DwtICA5M9hDaP1iutbFs/QH8DU1QRxCIq0FCzcz3Rf6wXv0AZLO/Hz5Cp?=
 =?us-ascii?Q?nRYk1RcpPVlu5/WN+tgfo1sLeVA4f4cPbAOnp60xcGYnlRxiOzTDiU+6cP8b?=
 =?us-ascii?Q?esukIVlVxd2fb1qdazAts3uQPkCNdF59+vTJUAANDuEIdmiKpul/M2MjeF6L?=
 =?us-ascii?Q?bryWljXaiguKnq5pkN/fJczrjKOLMZRyYLIEdRngPIzUMrWt5DblCYNfzM53?=
 =?us-ascii?Q?AWVkVmP5He8hftykNECwecieYg+ntbu/jjnkRX46+x2b1CWtdEzpMm8W4iiA?=
 =?us-ascii?Q?4XrkmvU/0DaacdPwJoRvPipj2wbNZ7Kl9grr0WLgZpU1yAs9RzPsdCJButdt?=
 =?us-ascii?Q?N8jCIqhJJEoUL9n/Na8n7YuozfJ1TTjviMzGz5ARvYYsfF52nwADdY1+7cdc?=
 =?us-ascii?Q?FfeLUEILpV6oKLt9VOJ6v1TKOi+kXTI63vO1A5rtV4syfeKhekhHgSET6BRP?=
 =?us-ascii?Q?ISqJaOwCc016xQfiXe5YJf3xle8JjbEq5ZmwGwtneXPHld1WFKo9HdXsAkwj?=
 =?us-ascii?Q?tRsOEV0NuiU+vZ8vT/q490frOnBb088wMHvt828XWWysfBHCIqZJbRAAEPod?=
 =?us-ascii?Q?tylWqGA2LvzxhJY0edg/6kiOgI7fdyegNXKSU4ywjYeMNmrmD/qOrCkPmfnp?=
 =?us-ascii?Q?J8TZggocj5CgBwmyP6Ih87moQyPGbdHBqNtvLNQH3+efvSBiBrUtojO3fFZE?=
 =?us-ascii?Q?V/krcY7iYUI97dudFKQoShQwaAE2FCk7ii7o9nVCu260BaOjpnzVNlfgxFui?=
 =?us-ascii?Q?nitwbK+pp20lvnnmkqKokjVlTiOxndKMFK8UnFzTfBF6pziDHEk8gZLjo9xs?=
 =?us-ascii?Q?mN04WiAYyVvssBP8WpqGVSwxlJrG6QQ/qTFZ9PvtLgsZINs4Z1IO1i9swo0t?=
 =?us-ascii?Q?iBmfhCXgFDpYEicrQgv0H5NtCKdasZnF1/y4gVqrehbJZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M6tfm8YXWZMZcmBNwxcLudZkW1KlQhrVUtsnf1h06QRGPrUZG4VBuOLN1LEg?=
 =?us-ascii?Q?9//kFLnXL9Gl7MEd+CAFrhPhWbapmdsnSbSRQgtq66tc+5ya14k/bTUL6PNO?=
 =?us-ascii?Q?kpOsQsEUkvHUl6nTXSnXgl69fjQtvVfbNKRfhvvLdFzWsTTpvVGS3Wq00mFr?=
 =?us-ascii?Q?EST3+Hnzy4Xk7CGo5DscVz3MICDXq2J1bn2QdM9EX1N42fHtcRTu6t1nRRvH?=
 =?us-ascii?Q?mGQkxQZDBbZW0dzv58oO1ploOs2t2Y2RvRdlUjTkbox4Kvk3pZK3Fge9di2z?=
 =?us-ascii?Q?oG2DLDXMA7O53832oVUDapDaC5/YWG3VCS52k2xGC54dK3EmFCZLoHfyV/Qn?=
 =?us-ascii?Q?fgwoOgmWIwMYZzyfnYw8HclInC0LBDeQdIwxasgF3RTzmEhvaA9APxkfwqCT?=
 =?us-ascii?Q?CMEWCtcLj3EK9s0xDQBtBv+tH8QBTskOV5aqxk7BTpyLiPjK/2fuiQhvfB+f?=
 =?us-ascii?Q?+KBy38AhiDgb4K7aQqO3NapUjv2iBVvhxCFTKEzdS0wTU1aLDVkNrwoL3ucI?=
 =?us-ascii?Q?bUoT4TGzuuN5PCceL9WWZHn+VevFdTqMeaMSQCaw8W0RqAtd9TAzaiofiSHA?=
 =?us-ascii?Q?kbsOPTac67+k1RW2iPQgmW2Rbi87CYlqIfEuL7X3drMO7adMC0rdWNzN8q+c?=
 =?us-ascii?Q?LAKHM7X3Pllo3IfqGtx4yj93Ki5F8FHSYGYEShBj9/L38AQpyqhKIcLj9gjt?=
 =?us-ascii?Q?gi3fCbuuJrtjx4NoNxnlvvuvfUrjI+qUREm2/uUYG0Vtq5X3ChAD6XHq+z1A?=
 =?us-ascii?Q?V0bAUop6YDij2AGg2QHggWHx1e7v/RC5FFD1DfbkRlDz0Xec7EWfTIGsIa3h?=
 =?us-ascii?Q?kRQC4N9GzHNf+3oR8KVzdNV5uH0uXMohUWaP/xhkyE5Wz2w9RyMa9y0M3ywK?=
 =?us-ascii?Q?fOyDveuxTk22IWFlld0DKaYFHDlBbAxY1b2YT5JQuSdHapqvu4ioHCI5djh9?=
 =?us-ascii?Q?ZP+ZpwLlQFaH94Y4/G9OWB+3AO5YW38CJBLPTTlMe+JQJxmeFuQP9ltNn7lu?=
 =?us-ascii?Q?FnBDcJf/DwoxnwyXvJ1dLPVq7+f9tbjUhmPaDiEMoG/hYPycWkR3M9Yr0DgD?=
 =?us-ascii?Q?xmE5i6Kw8gGcfaJ18gqDk2+axe7tPRUlCG2qMh6Q4qfZylnAkdcLkZWgaEdK?=
 =?us-ascii?Q?DuGZE0eRzPry6tZTa3TkvzxoSm9qgSyBpnUlL8qwaeI652DSBZlIrDhct7Gz?=
 =?us-ascii?Q?BtYvjIWf74BgHFaDYNPVpApzB7yS7V5pZuC9zH8tmEvwr/wQ3bFtQIp5yoRe?=
 =?us-ascii?Q?Ni3Q4NcFqP4qZDULfHSEz6vSuSMfy8TwGZskN1BHgmEc6LPHfqgLbDk3e3xj?=
 =?us-ascii?Q?KeSJFIB613v9oBHTnmaqy1qOmWCv4jbA3dGZyh+wKfCAXBxg8b+wH7bc86sl?=
 =?us-ascii?Q?JaMb/rCe3tZvq2kT2PgKXvQC2Jo5dC7Wk+Z46pOA13ot18oVV8ZwALnEgmXZ?=
 =?us-ascii?Q?Vtvoc/YHVGhm25BXnwUvJfJDrDHJcW4+tyPjFL3hQDj627+qOv40TOJlHFJE?=
 =?us-ascii?Q?fMwZY02pS+VIKtNd7m0XjXw833IG/QTBSXCGI8kbvQzwNeBBfY20/8a2AOmv?=
 =?us-ascii?Q?cObbC/1yzZY0GH7QpQ7IDdhdOhiEq7sK9FxEV1iC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cda8f328-9a55-473d-77eb-08dd192037f0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 13:40:32.6434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZs55d+ngumyAYK1WD/RQzluJn3on3q9tWMBt+uGeM6uqhu1wDsrUpF5PNTzQDfq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768

On Mon, Dec 09, 2024 at 12:35:14PM -0800, Dan Williams wrote:
> Jason Gunthorpe wrote:
> > On Thu, Dec 05, 2024 at 05:21:13PM -0800, Dan Williams wrote:
> > > Dave Jiang wrote:
> > > > Add a cxl fwctl driver to allow sending of CXL feature
> > > > commands from userspace through as ioctls. Create a driver skeleton for
> > > > initial setup.
> > > 
> > > I don't understand why fwctl support of the *existing* mailbox needs
> > > yet another sub-device and driver?
> > 
> > It is how to modprobe the fwctl driver independently from the main cxl
> > codebase.
> > 
> > You want the fwctl parts to be in their own loadable module even if
> > cxl core is built in, and the loadable module should auto load when
> > cxl is present in the system.
> > 
> > Spawning a new struct device is the best way to do this.
> 
> I agree with that, and CXL is already a multi-device subsystem for the
> same purpose. However, a device just for the few subcommands that go
> through fwctl feels too fine grained. I would say either move cxl_mbox
> to be its own device with a driver that does CXL native commands and CXL
> 'feature' commands via fwctl, or create a 'CXL features' device that
> support any functionality implemented by the 'features' command set of
> which fwctl is just the direct command submission ABI for that driver
> which may have other ABIs like EDAC associated with it.
> 
> The latter is similar to the proposed cxl_fwctl device, but focuses more
> on the 'CXL features' aspect and less on the 'this is a fwctl module'.

Well, the advantage of slicing it according to subsystem is you can
slice the code according to subsystem too. If you have a complex cxl
device then it can't just have a simple driver in fwctl, with its own
loadlable module.

I like the idea that the fwctl interfaces all have their own loadlable
modules, it gives the admin an option to blacklist the module if they
don't want fwctl for some reason without impacting anything else.

The original version of these patches used the auxbus, which is
intended for *exactly* this purpose. I think that got a bit lost with
the feedback to use the cxl bus instead?

Jason
