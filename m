Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9E7749C
	for <linux-cxl@vger.kernel.org>; Fri, 30 May 2025 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748613082; cv=fail; b=Rrc/P2htrNydHMRoIfStXF2pMmimFbG4XoRTb+hilQwjYzhtKp4TrxazSsbGUNXJyXgGV0UchEfIKuYrPjtBR/YEvKJqup4wIwKytfG/q+MJA4tiX7D3V3wg/+o4JRYTakrwEWN164+qaFQ+mgmskMogu/rubYELi7m2BeRMojQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748613082; c=relaxed/simple;
	bh=WnZSwkhhra1tjy4GAnBID6qyxCsqq3lNHOkmxtcX7R4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C29tCOO1WEw1TOhClTNsQEi5Ie76wXb8unCPNdfEQK3/Ye7oy67PCuGC81ogLinl/Gy8ls84sHPWOBtiu1bSl0xmtX89sdv3W+83NbM+4Wt7wkMKf+g0S0oC0ZIg0XKRjDWO2nrtu66IyMmgDasdCbdZuUxV+BbTKHQ7TOm8syA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ASZohPKY; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ASZohPKY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AoSfVXl6F5NJpdjQBwhDUarWVvatG+aNS6YcFwmDw4ZjNNtAHnBM9BsQYaWu683MIE3DrDZXsft3jQ5Y+9M8xShWnmew3/GDRZ2+hhmEejehbwzmuPCfryO5nG2CBVZBa9KdpxDLalpHgxDpVXYkP6Ebzs0pO6wp73MLLXCRJDlhD4D7VVQgmJe8KOfA0a/tTy6I7bv7UElK9u5jQoD6h4QHcxCQ/qjPNkgFzhvDwv+ghxyRlC1TkT7b7YfC7LsI6Lr9IBWAkiMxEXdPt2Oz31Y3y3YQZJoQ0qjPUlmRYqd7IIkHrykFmoujVGS7UiNnChfqqoqmEUVx5li9JuKeoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKF4RG1k0LadCjqK4FxQi8Xq2//pfsRIEY4DXJeKnJs=;
 b=CntTI3DQq+Wnj2qG/gbGg42Tgom++Kc8N6T9K8z8NaqDS1Y4lAcIgWW93CbBhOXS3t1t/UQqCeB9lPrgTXRobYDHMBpMkJM78rGZE3JKJWISS36G9HdnoXg7HGloKwQCfAfo68F13ELadkPPKBakEu0XjcW5RIkTTv0VDfq8eg7PRb+OWT2uIlc8phy1ge5Npqe3RCXToou3x4ybMOhWDyaCjeugZEyaTwS8DD3zCpelqdG+wBHhDBSRH6rLa7T3umderkVpu+B8D+6Wsy+zAMu3ZeCuEoDJuh7vqwK+hcmbIc8fRhFU35ILEG1x7rpnJMUUzJaWrVBzJCe9lFPm8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKF4RG1k0LadCjqK4FxQi8Xq2//pfsRIEY4DXJeKnJs=;
 b=ASZohPKYwcUSUZ8aUv0DBgPESAflTUET1iwOnphD3v9vf1Tm8vadRJShg29fMt97mwCNh475XIAW/BFHCgKbE3Xnp7YcolwYW83ovWVNkBT4PNys9DVVVDNAN6PcKIzZRII0LlAW/9lBzfShldOAmsu1ssuMTq5Y8QVvMEP7t7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Fri, 30 May
 2025 13:51:17 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8769.029; Fri, 30 May 2025
 13:51:16 +0000
Date: Fri, 30 May 2025 15:51:09 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, alison.schofield@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, Alejandro Lucero <alucerop@amd.com>,
	Gregory Price <gourry@gourry.net>,
	Jonathan Cameron <Jonsathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v3 0/9] cxl: Delay HB port and switch dport probing until
 endpoint dev probe
Message-ID: <aDm3zR2LkC3joLFL@rric.localdomain>
References: <20250521183443.3828320-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250521183443.3828320-1-dave.jiang@intel.com>
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dcde8d2-1639-4ea3-2b17-08dd9f810c65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r3dG/08EZIdBfXIyT9GgeaVc5RRH9zq9WykQgyz+DKceE56pGApRbIpyFtzC?=
 =?us-ascii?Q?VcR71jt7J5ZXpW1m0fjnWfpQ5NIr/nPxD8NyFJ/oR1kmYGEcYqOTf1Szmt/2?=
 =?us-ascii?Q?t6dBvuR+A7GcMNlCwz3+fdr44ZeMgAz32YoNV1zlAf6Aw+5r2dEb+ZIU+VQL?=
 =?us-ascii?Q?/CN3iOWISEJMVaBKmAZzCnhzG3vFdZBsVZzwIksD2+3/MViyON2jP8XvRbBk?=
 =?us-ascii?Q?nXuIrIGHEgVHIdvqOOs9AoYzjv3H0JJtqI2dChW3PcHyt/FcCnR9MS7ncFzO?=
 =?us-ascii?Q?iCcVjyUfcwhAcOZON8Uz+jDpZ1N6XadG4ZG0B/E485dmFsQ16aBSuSmQOCZs?=
 =?us-ascii?Q?/L/tbRZ8TdX/YVdOfKFYou71AkO8eaqGTac92PFlPmKHPLfHZEybIx8NR0CZ?=
 =?us-ascii?Q?xGhanlS/dpKHoY/TYtLYgowfb+9xvVVjkoHDpsRHD5qu9el6uZ2EP78HQQXp?=
 =?us-ascii?Q?EBbrf0AwzDNV4/jbkVjr5rJOkmSMClma8IxkyjYhRr70+ZdEIY9BPpACBM3C?=
 =?us-ascii?Q?5BEZfG2qrLr3j/y4Xgopyw8SOojxuD309zXecZkKAe5hO9hgJhaQiDvHZEhv?=
 =?us-ascii?Q?78D2HfR/+ZP1RqFnEvvte0Fbi1hCwDx2Mxy5hy+m1XV8XVZxTAGbakJ7ZTgE?=
 =?us-ascii?Q?EncX2DoWoZ93C7r/ildXS7CrZ8Wswd37N2H2PMk2WnzfAMwjKROk861C0R9g?=
 =?us-ascii?Q?7WiSJDlpy2DDQ98a6Z9ufXvzqL0NSuyFW8WyeiVEbMbqqGeDEwLDDhG3mfEW?=
 =?us-ascii?Q?H4uxyqz2qFtraZ33y/ZxXxEQLpGjnV6y6ioqf4XVDKxKpAmUkjciOefJwkSh?=
 =?us-ascii?Q?jPaqQD+XKLn4okVOZzEUUaFBKZ3E2vUsmCwVOZINYUhLTtDav4wEIFuY7chR?=
 =?us-ascii?Q?qmVRXaS2ICmCL2P25lGC230hrrr3c+JCJPmsYNLwnslRmmsYOqtoAeY4rYlz?=
 =?us-ascii?Q?HO1kZFZYH+EGvmsEsnnzRJNHAL248gGQv+X+i1dFlXJKouliieBD9zDkiaMA?=
 =?us-ascii?Q?7+UtKmBGmOcNAV1tnCKZdVUzKMc0CcmsgZUwoIn4Scm647+uo7bnrNvKE+uX?=
 =?us-ascii?Q?l0LYr5jpJy1vZKL0BwEdEdI2T0Szx50D6dHtbgGQdDZQECGY1VwcHceifXOi?=
 =?us-ascii?Q?GPFHxaXAALabYlEwD0/vpR3vU6xgzOJh+wJt8fJI+YZZSpEanLmdaKtJOQ1s?=
 =?us-ascii?Q?C1wI7Cyk7EFF/ncVcL4g8ip3eIegBEiMguHBL0PPk8xs0SQCfNjLCVpaZeZN?=
 =?us-ascii?Q?dVvUXJnVqQwvhMFNIWmU9jBDFhufAc6X7gXBo0ZqCMJ9w4XXyJk/uKcucwLw?=
 =?us-ascii?Q?xGkIofX3KqEly+oQ1SYYl0va2RUKEfmHhAHsO4azI5o4aqf0ktwQWXHIylxO?=
 =?us-ascii?Q?/DBey5udoDrokBaD8+s7l8/d0MGORDokMhW8pDGYuMhsxUa+XC9Uw7OZlY13?=
 =?us-ascii?Q?1Am+DlSCujU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PupmqexMfP24czSREsQcWZRcz5W1nJcnBTlO+xiR6PjSNT7zr/FLfOasF9Tp?=
 =?us-ascii?Q?99xNrpEnAhSoFDWpk4iSopwZ7j7Bfd/HWpJFKdK4WymqT0PuAzZ6d6TZA4g2?=
 =?us-ascii?Q?VSdktLG3OaaI7gokn0qUeVPB9HBsDwvF26RvvWkf0pAGlBAF+j+bjyYKjghY?=
 =?us-ascii?Q?fc9Bz0hwbWp4hjxVDvjBnm/gEMTMXsSmUADEeKv5gR1DskWnXYLkO3PzQyAe?=
 =?us-ascii?Q?Fwe7ohC8H7zt+8Bz2xMIUd7j6lwGXVQFeMCebCF3uyzQEtdVnBjySGpXU7VU?=
 =?us-ascii?Q?8Y77R26lTixhmjA1f8uuoZZ24fRZyOEZvaUOTLGSdlo9WQhp+vEqCzfTRjRV?=
 =?us-ascii?Q?y/TBNBTBEpQdLdpNNQW9yQ0MDVedf1wa0QK05sMpE2pHtRLU2+YtBGdWU8tV?=
 =?us-ascii?Q?p2X4dB6bHbN2wknXOvAi6F/09V+zLRO2Dfj1+aEk9n1n5lk3QTKuikqUbe1h?=
 =?us-ascii?Q?m31P8BvDxwPB6lWpwkGsL1OipD1PDwRUYfwEGDgMIHc59QPp76yyfxJk/8A0?=
 =?us-ascii?Q?f1rLC1EG1nx6l95g9klCkMZU8pNpdwADOfY34bGR8YWcHIaW/NsFsQKAZxd8?=
 =?us-ascii?Q?t8NMUwdgLwimBqQX+9ntuWv2yA2PAqI+UM6XJJQpBrXcHIxZKTw4WtI5hXNi?=
 =?us-ascii?Q?8Olhe3Vzno0VHfblg3blqyGC8vrJbKEB7Tmk56y3N+VzJ1fk05m6vd8y/5uu?=
 =?us-ascii?Q?nEmaS9Vkzney/aEse+IqdVuHElbxdVNa1sWmkoI5oz4B2UVlFoj3KHRNarem?=
 =?us-ascii?Q?cwOPNYbu4wblbucU0qZ7VuJGYEG/A/fUmKJ9rw4v5sr5w3zRctsL1Rm10CME?=
 =?us-ascii?Q?4Bm+S7cOGqBnEdvfBHFiQ4N+FK2+RgZMgN3vDvgVbBkbV+8Sv/d8xhTphlOi?=
 =?us-ascii?Q?WdoPxziMCqv0fNDfx6Of8b586NNxiBolhDU+EIQDU1T4GKyd86MjRzWL5sZx?=
 =?us-ascii?Q?+rxu7D6oLW+WFFvj153vS3Ctg8lBt2ujI5jmnBBim53ZS3B0z4S1UsbbpYU/?=
 =?us-ascii?Q?X86Z3gcaLjdbf+1wt1z9DI2iE4+Y34IU17Y+ik7f4W4fPDAwDNfhAonzzCLo?=
 =?us-ascii?Q?rnbOsce9a6QGfZyCTqIxV/M3r7hRy2CDrNEC7VDZMgNlHLpC+n+b99Lyjn0r?=
 =?us-ascii?Q?oHQn+9lTjHYUMAEAFdKI+pFDVKiL6BylPahsZRRD3R0rEPKRJKD9Eb7yDhBP?=
 =?us-ascii?Q?01PjIucQN234AsJdWsG2QYdyb+Lit2Dr3b1qORZsUy6HzFnNTErzt/IS82Dc?=
 =?us-ascii?Q?8GrhNTJ8Rq1aZQ2e7WckNKnP/iA2fx6tUxFlFpLqDpWG+K9Mn3KILS4mns0s?=
 =?us-ascii?Q?qAQBwSFT7C+ophTRhB9UNTEn9eKSXzw8sW3s1a+U0NtVHSoQWzgZB3rUpkKH?=
 =?us-ascii?Q?+zbZbRnOb3Fd63to48x3GeC25BJQ9qA/cLCYWaoHcu49pI6fpvSxGIE+e/vs?=
 =?us-ascii?Q?rlsGTxWT1DBNl1V6Q5DyTt1IMrlJJY9DE5UxBVgUv8yraaHq8XhQzJ2R8Lsd?=
 =?us-ascii?Q?PifiZKg4IWVYMZ986jcfZzGRMTE8JYEbN9G094bcReHZSDQapCeEP5YTFHSH?=
 =?us-ascii?Q?Hy1W5JvVKk0Q+u+9lcYjQQxuGP1/s4mUMuJ5xbkx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dcde8d2-1639-4ea3-2b17-08dd9f810c65
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 13:51:16.7453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yVpMq0HL/BcZOjKMV5W8u9XgXZeaFhloNjlyVwPHGukn0uPAldWyMjQkgksBV1zQp6T4UkcS6s6UbTsixmx7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558

Dave,

thanks for your series.

On 21.05.25 11:34:34, Dave Jiang wrote:
> v3:
> - Main changes revolve around improving naming of hostbridge uport and dport (Gregory)
> - See specific patches for detailed change log
> 
> This series attempts to delay the setup of dports and Host Bridge (HB) register
> until when the endpoint device (memdev) is being probed. At this point,
> the CXL link is established and all the devices along the CXL link path up to
> the Root Port (RP) should be active.
> 
> And hopefully this help a bit with Robert's issue raised in the "Inactive
> downstream port handling" series [1]. Testing would be appreicated. Thank you!
> 
> [1]: https://lore.kernel.org/linux-cxl/67c8a0cc23ec_24b64294f6@dwillia2-xfh.jf.intel.com.notmuch/
> 
> Dave Jiang (9):
>   cxl/region: Add decoder check to check_commit_order()
>   cxl: Add helper to detect top of CXL device topology
>   cxl: Separate out CXL dport->id vs actual dport hardware id
>   cxl: Remove adding of port_num via devm_cxl_add_dport()
>   cxl: Defer hardware dport->port_id assignment and registers probing
>   cxl/test: Add workaround for cxl_test for cxl_core calling mocked
>     functions
>   cxl: Change sslbis handler to only handle single dport
>   cxl: Create an xarray to tie a host bridge to the cxl_root
>   cxl: Move enumeration of hostbridge ports to the memdev probe path

I have tested your series and this solves the enumeration issue with
ports where the link of its downstream ports is down and that have
duplicate port ids. For the whole series you can add:

Tested-by: Robert Richter <rrichter@amd.com>

However, some observations:

The port_num can no longer retrieved using sysfs. Previously, the X in
dportX could be used to identify the port number (former port_id)
which was identical to the numbers in the sysfs target_list entries.
This is esp. useful to reconstruct the decoder tree and map pci child
devices and its decoders to a parent decoder including its positions
in the target list. Maybe create a targetX symlink from the decoder
device to the child decoders of it?

Due to the different initialization order there is an odd port
numbering now showing up with unexpected, out-of-order sequence
numbers, e.g.:

/sys/bus/cxl/devices/port1/endpoint2
/sys/bus/cxl/devices/port1/endpoint3
/sys/bus/cxl/devices/port1/endpoint6
/sys/bus/cxl/devices/port4/endpoint5
/sys/bus/cxl/devices/port4/endpoint7
/sys/bus/cxl/devices/port4/endpoint10
/sys/bus/cxl/devices/port4/endpoint11
/sys/bus/cxl/devices/port8/endpoint9
/sys/bus/cxl/devices/port12/endpoint13
/sys/bus/cxl/devices/port12/endpoint14

Still, this is correct, but maybe we could force a specific order
during initialization, such as per-port initialization which should
result in a defined order? Note the shared numbering of ports and
endpoints is also confusing, maybe that could be changed here too?

Going to review your patches.

Thanks for your patches.

-Robert
