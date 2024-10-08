Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201A1218D62;
	Tue,  8 Oct 2024 22:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728427080; cv=fail; b=K7hkDd1/xZdxSVcXu5dCgGodWPopmcslkLyh2PCOC033xuBpawcE117OwwMuo7n2fgVKsVInJt0kQeASsqu5QseYcMJwCtiWnVZZm8zE5VnU1RiWUdtvriLRQjHXpoV9j7CFddhk/w8ARzy4dZWGjvZGtO7AdalXZuc0hyv2uvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728427080; c=relaxed/simple;
	bh=R3+n5Q9u8ZHJ9nxy2T910IfG5ZOuK03elrjWogoKK1E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OvtUq+OiKP17n9AI7oFnWtZIKphQq6cNbmgTQQfAldQsORb2suZnXVkwGzfGk5ZL616UqPkk2Tg3Psm4JaMybf/ICgQxihAF/u/SCUcsgpk5hYZuH40T0wf/eP+qhZiqkeViy1gYGnqszim85yCXPj7WSuPvAjukRrFpv1qmveo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gxzm4XzW; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gxzm4XzW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728427078; x=1759963078;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=R3+n5Q9u8ZHJ9nxy2T910IfG5ZOuK03elrjWogoKK1E=;
  b=Gxzm4XzWvVF5VQhhwPAbYOfV46/7XbO5X5q3zXzPpcvabrJ0UTHETD48
   AoW9hurWY/b7OZsYaiCOlaoJo0ixnLnghVyrfxMAY35ShBtr+nZdQHADN
   KcMEovaiG2qC+NFkYAfrgjfKRnr4P3MNn6FJJU93C2J89piTbsKWKGEwW
   rKmGD+LZ2RsujY6ZeAYuFnzGkFOIRhBks+VHBL49t7hkCid4iPPeUsHV2
   7my2x1NUQ88gM+IgRcBb1ge94gxYiFICZB9wrIVuGM13ejSL9QDISD4ff
   W8Nhm2eUjI3S8j46Lwo6PJSTDTXQZqtB8kHar6pDsmCIV9F5/7BPZHAy6
   w==;
X-CSE-ConnectionGUID: x62s97TkQveBVnvurdEWYg==
X-CSE-MsgGUID: n8O0te0dT2qRV1DHWPr2zg==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="27802955"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="27802955"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 15:37:57 -0700
X-CSE-ConnectionGUID: WoN+wHNCTLixAAXZsG4H0w==
X-CSE-MsgGUID: bKDKv9CgTk2oPRoFQFnRWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="76017888"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Oct 2024 15:37:57 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 15:37:56 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 8 Oct 2024 15:37:56 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 8 Oct 2024 15:37:56 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 8 Oct 2024 15:37:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nBKaX/cvyOeu5C4O4z7/yNH0h/K/4Y+zDaC7+VBzL+8JSnu0OKugCwUpER31Qwif/cSPJu0T0c2ykk0jYrifPk+VzknD/zWsyFllywvEwDVkDSAg5xj1BLFMVbMh9vZt3uSZKUFKwG6KFxpL1K1peVkaaLNtjuH81cQkHJvyFdMuH9X1CWH3y9+CtaQKngnKpIBRnb1Jm+l6u7IxtDT8Dv4yUlFqviEktILFMJSOCvwB2dmk3MK2r1TK16913Z72XenV4cTG8IIQ96pgzOc5MaMjK27SFLBMPgPWU++OIBWIoVsHYkZuREHHgpenBU5VQClg7whOXMQ+YFA1Gl8wVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cf84MJf8qEm4zarVDbjdJCeqWsatabcH3jjXRzvch0I=;
 b=vUV8ws/rU2A35SCT8l3fCExUJGa5UEl9qy3g+VLS6dmnGNAwY7YasnYkrcXd/CqJ8ldvHV4jPHJ6eQYroOicMrv8fL10sOsrZ9rJ7kr05zw8X/AC+0zzpBEDt8V4V7gYiK4xqiFO5yaBIXiS4Hw5T77FMGljvl9WquWoOp0QScIB/Jzy9LwCyOVAgVP5sg71yp7NLOm9zkB34H+Y5nYkbQL6YXCnqSlrmHaRnA2Q+qBK4aN0xoaGvL7N2nhA+Friig3zIaCQdOwp5tJV/OsdrXS+GEi5eFjAXXusqyjyf/4eUm08FX0uxCCdk0AlkDAGpLpZ1K8WEae/DMFcZP+SgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 22:37:48 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 22:37:48 +0000
Date: Tue, 8 Oct 2024 15:37:45 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Gregory Price <gourry@gourry.net>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Jonathan.Cameron@huawei.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <rrichter@amd.com>, <terry.bowman@amd.com>,
	<dave@stgolabs.net>
Subject: Re: [PATCH v2] cxl/core/port: defer endpoint probes when ACPI likely
 hasn't finished
Message-ID: <6705b4398f0d0_964f22949e@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241004212504.1246-1-gourry@gourry.net>
 <6700836317627_964f2294f2@dwillia2-xfh.jf.intel.com.notmuch>
 <ZwCe23k_IDefi15j@PC2K9PVX.TheFacebook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZwCe23k_IDefi15j@PC2K9PVX.TheFacebook.com>
X-ClientProxiedBy: MW2PR2101CA0003.namprd21.prod.outlook.com
 (2603:10b6:302:1::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: a2efc305-85cf-4c95-4f97-08dce7e9d5e6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W99uZxr3yTjQ7zpZkrUjGoL643YiKgWGoBxqA7J6FAdQ06t0uOtcZJtuS7cc?=
 =?us-ascii?Q?4SAt5kYyABNEyehn7iI2Vm8JOvgUotVmywJHdgDBz97Mze6qcPDjkU0eES4b?=
 =?us-ascii?Q?TQxd8xAqt5IWQnxZ18JIBZEsQxrP0hU6XNu1RRETfoz4L+IrKK+obcFwo+jt?=
 =?us-ascii?Q?jQk/jNgjXOaY9XNW7fXx3s09frZ9QxtE/AGMwG7j3/9+Ncpd851GvlTvowBD?=
 =?us-ascii?Q?OqJmTkuDawL55HD8oqxLkasJ5Jn7u/9UEKjZ5M4I1XS+pLyBonxrdy8LcR8G?=
 =?us-ascii?Q?iappFsgPOWbQs0mPmZkkwWjiPKm9yNrFWf6cFeI7IJsG7XfSIhf/ikCbFSyG?=
 =?us-ascii?Q?Vq7ejsJbeXVCClzlpttLXJwzov6y3LuBIR1Gp75Rlgv39C5cjXU0qJ1n1T6n?=
 =?us-ascii?Q?lnJHRBMg9cqJoHwrURdas3HzQd0Q6rLn4fkmM6ca70cM8EPRrPlgM614iXJl?=
 =?us-ascii?Q?5TawSuqNyJdJSNKTn8PhEPpwmS/5qWY24rTp+2VFvsK8Ggu1UJtHudcj06oI?=
 =?us-ascii?Q?0eIiC9RqKJfSBrzVy/5QALib8vwCrci1PGhHqYQd5C7/fGPOv31x2Cjfviyu?=
 =?us-ascii?Q?hoPi2cTD2canh0EWPtFPF/iGRl6XcokpA68etMkMLvlkXbmma4smtn6y+bav?=
 =?us-ascii?Q?9sKkxcho7Ujgy9NYVaHldOvx8iI6F5MJvGk0tSQQHZd4UvBAOhr8KLuJal5N?=
 =?us-ascii?Q?MaLVStOlKwHLuCnvqcwXnHNj/4zgaNk4xiLZm75aZiw9Me7moJqBZiqW6n1a?=
 =?us-ascii?Q?uT1oBktwJPnRWDtH4ka9JLuee3KHqHEcm4N9dHmqSOZFhDgKg0VWjYcKCCyO?=
 =?us-ascii?Q?944NUZPsAvrWFfIAjs5sCBarGuya2NoxgcE/KXH4017sI2637wz2cWSBH+nM?=
 =?us-ascii?Q?Y4TieP5fXU+IPezYy7JhphfXvW8JcU74LtnXeGKHL3df0UWNqrlOYyHsYIux?=
 =?us-ascii?Q?wFlsl/l+G+eZD3htKEVN+y+0GtAV67oL+AbgnK+TBzInZnZloiaV4YUPwUkf?=
 =?us-ascii?Q?HoIJl/T91RBbdFi48JO5FSK1x54BPodKKnSJRMS5gIpcRO61NCa7oO4asgyb?=
 =?us-ascii?Q?kC1OLcgPLXddaBVJH6fCUldfY1Bz99zoQfwtVHvPVUhL7SzBZFxGhJ8SyGxc?=
 =?us-ascii?Q?3kADx1nMbee3JeYgkx+SYCDYedxlGsb0uplfXdFfGcDPBsgIQCyeK0nvTg9N?=
 =?us-ascii?Q?4DPce9NN2RvrzNk/s6oz+TM8jsN3Ile5u0x17YD5S8oBwg9S6Ccg51c3ZJxf?=
 =?us-ascii?Q?5ZqWcpnK0JF/f0ceqKRV/zMglcoEySM6eZJ0FPPIxQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b8S0Hi3oQg3tPTUAplEHlTMUC9wZKrGF0DnlzTIVKE+jdSAAlOpY398+IQ9W?=
 =?us-ascii?Q?vRfNx3Qop24SMf9A4Lwyz/dCLrryHLShVlscYbcnjANO0FwTm7UNOVTBQjOd?=
 =?us-ascii?Q?GwE6hkFUpGYPM+bq0KF+ikme6MQSo2jCKF/nbOZkbAZZi12WGT9/x5Li0Jga?=
 =?us-ascii?Q?HjYuHRvNgPoEogNFwwS/5S9DQWiDXG52AvdnWac62Ye7ORY1YiCEjubY/qu5?=
 =?us-ascii?Q?koJNfkOqLv1TI6omRBNVJlRXroicXGLEW/qzY2DWoNTlh+vUwZw47ieU05PN?=
 =?us-ascii?Q?Uj4OPRbV9SfEIOFcYZ5SeIKYkx9HE+pnAinE8gmzKMrZyLQnbs+z3HC6gS3n?=
 =?us-ascii?Q?RNK0j8droNxcVW8yhGnchH6a+N++x5dhXjzKa5ZzF2KtCcbZ3t9lJ5DbaOXm?=
 =?us-ascii?Q?2yRpnVxJ+q1k16zg9GZ/ZYdv8TE064JYAOxmpmcSZ3RPUXJ/295ThL+ZHPDc?=
 =?us-ascii?Q?JnJuAypwRjKDO7GkPuPGSymAyst6G9SiyId/9vBlumiH7DAdeaa6fEXZ+eya?=
 =?us-ascii?Q?FKLKJTEP/kja8MxcDwWk/ZjW4mPE8jXkZwguW+tkorK9Wu/lUM6r8NJaieKt?=
 =?us-ascii?Q?V7VQalMmCgsf9gAONWHOlOU9ypmPMTwKJkbKVkyLmBfL8J6Tnsj2Q+cGz4od?=
 =?us-ascii?Q?0YKS7hAvWDuZaor0TH5zn5mMcQ+cZJlnPc+lbXUkRMpoOIb8FBq8/aP622K6?=
 =?us-ascii?Q?bsFEJDd/fSrNfZOM8OwlwbAlLMtqiy8ij8U87Y7JtVlwd7kDBk5aFcr5FJKk?=
 =?us-ascii?Q?sEInCMv5LzYKltK4HBEQPIh5Jv3lY8DgxxYgMPmYjSAsLXGbRpz9OjVfxfc6?=
 =?us-ascii?Q?eRB9o5Rwy+LhMC/m2MExbkzGA+o7LHmPxdTYc9LFcWmZSAPYlDRd+cfTZTC/?=
 =?us-ascii?Q?LQymwEzuQurtUEblZNDNzpZeP9sw1qYCOGRZJ6BIYUT/u8KE7HccHsAUspkW?=
 =?us-ascii?Q?Q+3wToOa/qwbpQSBSmtB72/uJz+qIYFu3qKbXppkTYlTqc8K1vJvp1i0tJwL?=
 =?us-ascii?Q?F3AEbFDFBksTuYYi/aNA9/jdYhZ4cqlLksnmQQrqoxvIGP4nHzTaZ7a7pAwg?=
 =?us-ascii?Q?nWlMZm4mjN6AoCFG4Rb0tyqSSxawrgTh9FGFsJ43rWFCkZv7EmqU/Qz8K/lR?=
 =?us-ascii?Q?4gEV6C32DYN/Qy+8a4MvH8uCqzC5V+b8VlPjVH5eoYqfN0fL4bLf67gtjgmR?=
 =?us-ascii?Q?Q4TBUlDwOAhP7lVF6DlKnxbSSy2A1p+g3sHuEcTynM7NsaxBJXoXM1sLuYVI?=
 =?us-ascii?Q?RFDl7QrHVMbJMQZT3HZD0yfRZ7gxsB0yQYql1OEtMuNSmfOvvFnVJjGEbP9H?=
 =?us-ascii?Q?y50IdYzHFd+yDHcC5WEjpQ3nSGRSFYhcMe6fd7ynpm8LIxuK+CumX7xMJi54?=
 =?us-ascii?Q?chUssT7F+wvdksLxB154LFBtH3yuE6d9jLSXLPf/RoFrKUHFNw3Y2aojctYg?=
 =?us-ascii?Q?BDno5zpYiF8uQ0La6LmKXVN1MiTpWyaXh+1ejLJ9lPcpUiBFYygi6nKSo/VZ?=
 =?us-ascii?Q?s07j+xBYPC4fwhIF58dN0Imkd8JoKMYPNg4vGDKJhY73guemdduAucVigost?=
 =?us-ascii?Q?kJc0GqEXOvGT/jfW/ZM5S8acsp9iLqduN/rqLzp4lM6itlP1m5PbRxTf+Tel?=
 =?us-ascii?Q?PQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2efc305-85cf-4c95-4f97-08dce7e9d5e6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 22:37:48.3156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJg62+KzKYV8VJaWHY9vPS+zWOwlljRhVxcBhpgfcnXRoPNLcDmyaRnp1xYkf6nUXaN9udoboI8Et01LJDaqEhd0evYPIuv3HGUjmJVg5vY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7772
X-OriginatorOrg: intel.com

Gregory Price wrote:
> On Fri, Oct 04, 2024 at 05:08:03PM -0700, Dan Williams wrote:
> > Gregory Price wrote:
> > > In cxl_acpi_probe, we add dports and uports to host bridges iteratively:
> > > - bus_for_each_dev(adev->dev.bus, NULL, root_port, add_host_bridge_dport);
> > > - bus_for_each_dev(adev->dev.bus, NULL, root_port, add_host_bridge_uport);
> > > 
> > > Simultaneously, as ports are probed, memdev endpoints can also be
> > > probed. This creates a race condition, where an endpoint can perceive
> > > its path to the root being broken in devm_cxl_enumerate_ports.
> > > 
> > > The memdev/endpoint probe will see a heirarchy that may look like:
> > >     mem1
> > >       parent => 0000:c1:00.0
> > >         parent => 0000:c0:01.1
> > > 	  parent->parent => NULL
> > > 
> > > This results in find_cxl_port() returning NULL (since the port hasn't
> > > been associated with the host bridge yet), and add_port_attach_ep
> > > fails because the grandparent's grandparent is NULL.
> > > 
> > > When the latter condition is detected, the comments suggest:
> > >     /*
> > >      * The iteration reached the topology root without finding the
> > >      * CXL-root 'cxl_port' on a previous iteration, fail for now to
> > >      * be re-probed after platform driver attaches.
> > >      */
> > > 
> > > This case results in an -ENXIO; however, a re-probe never occurs. Change
> > > this return condition to -EPROBE_DEFER to explicitly cause a reprobe.
> > 
> > Ok, thanks for the additional debug. Like we chatted on the CXL Discord
> > I think this is potentially pointing to a bug in bus_rescan_devices()
> > where it checks dev->driver without holding the lock.
> > 
> > Can you give this fix a try to see if it also resolves the issue?
> > Effectively, cxl_bus_rescan() is always needed in case the cxl_acpi
> > driver loads waaaay after deferred probing has given up, and if this
> > works then EPROBE_DEFER can remain limited to cases where it is
> > absolutely known that no other device_attach() kick is coming to save
> > the day.
> > 
> 
> Funny enough, not only did it not work, but now i get neither endpoint lol
> 
> $ ls /sys/bus/cxl/devices/
> decoder0.0  decoder1.0  decoder2.0  decoder3.1  mem0  port1  port3  root0
> decoder0.1  decoder1.1  decoder3.0  decoder4.0  mem1  port2  port4
> 
> w/ reprobe patch
> 
> # ls /sys/bus/cxl/devices
> decoder0.0  decoder1.0  decoder2.0  decoder3.1  decoder5.0  decoder6.0  endpoint5  mem0  port1  port3  root0
> decoder0.1  decoder1.1  decoder3.0  decoder4.0  decoder5.1  decoder6.1  endpoint6  mem1  port2  port4

Such a violent result is interesting! While I would have preferred an
"all fixed!" version of "interesting", making something fail reliably and
completely is at least indication that the starting point was more
fragile than expected.

Now, I tried to get cxl_test to fail by probing memdevs asynchronously
alongside the ACPI root driver. That did reveal a use-after-free bug
when out-of-order shutdown causes some cleanup to be skipped, will send
a separate fixup for that, but it failed to reproduce the bug you are
seeing.

The incremental fix here, that applies on top of the device_attach()
fixup, is to make sure that all cxl_port instances registered by
cxl_acpi_probe() are active before cxl_bus_rescan() runs. That can only
be guaranteed when the cxl_port driver is pre-loaded.

If you are running from an initial ram disk make sure cxl_port.ko is
included there...

-- 8< --
diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 82b78e331d8e..432b7cfd12a8 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -924,6 +924,13 @@ static void __exit cxl_acpi_exit(void)
 
 /* load before dax_hmem sees 'Soft Reserved' CXL ranges */
 subsys_initcall(cxl_acpi_init);
+
+/*
+ * Arrange for host-bridge ports to be active synchronous with
+ * cxl_acpi_probe() exit.
+ */
+MODULE_SOFTDEP("pre: cxl_port");
+
 module_exit(cxl_acpi_exit);
 MODULE_DESCRIPTION("CXL ACPI: Platform Support");
 MODULE_LICENSE("GPL v2");
