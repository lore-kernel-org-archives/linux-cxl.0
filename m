Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63823344DB1;
	Tue, 23 Jun 2026 07:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782199341; cv=fail; b=E3cjax2253zqbN61vmm7NpS8gj3X6WQABr60/a2bW8BMTlrB62OhlKzO9CoVkqw4VK5n3FyveR1cgVMeLs48LnzSTnuv8lEbCH1By5+Zq1/EJVkaRO6wHMm7xcWMDJ0YrezJ5UbqDQvVMoSUmgR2VFED9PJRJ9vhKwRHKLzyeJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782199341; c=relaxed/simple;
	bh=2T491b7qFnl4cbs3WtTvB0BvLTbAAnRyctAOUEP8Ga0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dr+VXqd+GJ+bILrlTwjRgINvfpqzBpepwjBa9JIaUATw75MyKwzJaqbNK/XgfTcqP8Cv0GZZoMuaqpLwW6zbdgnsZQpzb3WiT3UsyzZLF6yPsOVWoJVFGvZ1i1pLgFEhVk2+SjJU7oAq/24AZpOweKj2luroFPrKEgHCqkZ3A10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f8Vlcdt+; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f8Vlcdt+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HzTgzq9USlLp/9mUu/M7zeGPTTkvDcXGs+Rqfh3E8gOv3g9ba6usMirrzeCaKETSOJ8UquShV4tHR3NsgeqTkDay9VfT74foBiBS6XQXTvHCbEF8//S8wgHzQ5AkbJTs5Ea4FIZx3GV/zC6kNS/jwO2G42dXpJESH8XcRdT0hqiL8Usog0ysixKcG7LjRdm8+UCxKZ908foH9B9ONtWcBKC6uMEDf/wfetYETnVfo8k1FdVXPe0OzCIBaUYB/ViWmyzWGOnlkBhDpA8HDyI/W9YWyu4kJXYEprJsQr46s5efIr3Cua0lyoSM43t+zHJ5n2kOZjxjtwfF9j6UWhyqSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fELTYLlh8NabX9lXwIWTk92fqPYhZ/OioYuE4VaOkr0=;
 b=fQDFbpdI5tsfyYvuHeuuOjTbYscLEktXJGsyXImWX4ahieicOKfI1wFjw1zbee3aygCPx1aTqhFffmOC2KuDTl6U9PqW/p67ET5mR0u95oOVnMy40WHTA4gih21yAzjTGUx0Ah9O7S50In/EJiVcgMXZOr3Y2W8/HOVbTsprnuSleenELZHWFhWViH95uA32DVMXoLYOSSKnFIl8tuDK7tZvbOm5x+ArowK4/pI/67pJV1tvkwuvh9CJNWZbCfzR+EDLZgushYne7d9M1vr2CwZ5hXdraDgKJ9KofMPvxuLKLIxD4+w5ySjdDZ4iYNq9PYHHh4kdz/9iiWh/IK6Hkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fELTYLlh8NabX9lXwIWTk92fqPYhZ/OioYuE4VaOkr0=;
 b=f8Vlcdt+ErJhQdBwR/T6ZE8ecDEkn8kiS796uvPyhTOhN6coVgIFeIboE88OqJrVoPZY2q750Witkiz321xos9FLyb04L928jO5zMlprtEPESuMcr4i0brG2imhHl+9anm5y4kWVPG2NZrQcK4Y/ws7FXFUiSZ9ipnP56sOkJ27XBUDkjTaQt0ONiom2x8rwsWxQ7U/PWdnm+rM/AiaGtPEMgup2wjhvH+6iqk/TuQS5tVOqgnvOgYi4vGWJCWgbtLNgT0i4d4jjfpg+PbaVt3oGAJjXAyRzN5mwpWHEytkMWgp+BF+lwk1W/9QLxbaIweSgzK/poAmIZkCvfd2luw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ2PR12MB7990.namprd12.prod.outlook.com (2603:10b6:a03:4c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 07:22:16 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0139.009; Tue, 23 Jun 2026
 07:22:16 +0000
Date: Tue, 23 Jun 2026 15:22:05 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, newtonl@nvidia.com, 
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com, vaslot@nvidia.com, 
	smadhavan@nvidia.com
Subject: Re: [PATCH v4 2/2] tools/testing/cxl: Enable zero sized decoder
 under hb0
Message-ID: <ajozhDmPogKi9hb5@MWDK4CY14F>
References: <20260607081345.61954-1-icheng@nvidia.com>
 <20260607081345.61954-3-icheng@nvidia.com>
 <aixM4NA7hX43Bs_y@aschofie-mobl2.lan>
 <ajkLv7vRScdspEKV@MWDK4CY14F>
 <ajn5bIu2lSrjqtXv@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajn5bIu2lSrjqtXv@aschofie-mobl2.lan>
X-ClientProxiedBy: KUZPR04CA0021.apcprd04.prod.outlook.com
 (2603:1096:d10:25::9) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ2PR12MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d807292-be38-4858-c26c-08ded0f826ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|11063799006|56012099006|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6TzHH1t3ThKV/Wm/OzC3kr0EeY12zxL0hvwsLk08CmJD+9T3dbjnTjPqs8KwTHr3vNVZJMBLE9Nnmuuj3WP4TNeqgOcQqMdGB0hTYYEifPX4hyJN+47q/Y/O7Jy19T03sfGaxYX+lf5ADJ4jYoG10sFgcVaQwF+BZCJLBcNv+v05E9phD+6Y5ty+AJm7qZbidtY9Z8XA/RxMSb5EHdGYHle43g9w7D3hoMgSZQXy9s8abkaTR402m/1f4xiVuPe08mLZ0yFO/h/fxxH1q48GvEIuDmENd1TAdu16DYRo5xzYF0FvagJGWDp5BuiwK6XWtAeSPuB5wwwPWwHfgZdM2aR4vlLP4+dNSa+an0uZv+7HrW5EcEjhcs0omHm0P1h+vA9Er+7vQDacjPp05DdekY0njNRweGpk0KTJX4NPe3eJNoM/kefB4TIVgjfbzLKADBKb8Y2MKptwhLZGMG104rKXVhYsjSiFGmc3GKLjvodj1zfIhTEOQ5dNrlj/nQO8uvSqI6rugNWwCivf8KACv1Fq5mL5+2VIJgsAo7oho/H+6z1igqu+ghLBSXjz5PMWwYXRNgp8a4izvPFpVILSuGy9CndABdvx+vL/HL4P3a2ZPvWCYzl8/B3033ySKVORoZZchAuKkwhQNqG+CWwxm/HTeEJFm05dON5QsDCKZ0Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c1MD35xdtUwunLvf0XpSyZhutcfWpUJeDMg+PrcW76d8TVwy4Ty6QqjMjVgK?=
 =?us-ascii?Q?0O3uhQLEiFEm3bPMEDn5ctZ0aAOCTkdtPetBiVM68CYci1hWlg4EuL2ar/Kz?=
 =?us-ascii?Q?7p67ATkbQO0g6ggY9+keR1wFgbXDn5YnmjpiLksSXK4K31ib3Ugeflck4VI0?=
 =?us-ascii?Q?LxbMyznV41LgI8THQnpZnE05VK9AClxOZkv6Kkf6R/3SFIrWG9FgsVmlV/DD?=
 =?us-ascii?Q?HnOXm3Dg0Hr9JOuAec7d9pCe0gynZ03YX9vLTHcXefE9HUng00hnAsfUmOKV?=
 =?us-ascii?Q?mhEibJfKkLq8nDF+dIdAqNv5rxYXZDFul+tTIQPLKgvPezF5OT/f8/3/Drif?=
 =?us-ascii?Q?m95Oqg+qPiLud2y2ngt+49pvG+Ug4L+iMh7SuFIEBLXZefu8mua4zmqmO6lp?=
 =?us-ascii?Q?xhkzicWJRwGdfvsTsR7QIHWo0NElHhbxiwN3qiQ6p/kUq1ZGXSCoJBCADC6y?=
 =?us-ascii?Q?lkWI4yiN4vW+WaDbPG+P/tFlhft7dWsf+C8H1+15biqTvVmKOBtsIP78V2za?=
 =?us-ascii?Q?ao29w1x97zJpKiZk6s5o172D5ChvQBDnDhoauvcUZjX4D9OcYI+2hSlDsmYW?=
 =?us-ascii?Q?RVwhPp1JWJTO32U1xggXJb9NoCTFJhX1Rd/F6J0kjmbojVdFV3TMDH3NOIa5?=
 =?us-ascii?Q?qyc3+7s3DmTFul2SUTu+bT0fKSs0oEqSM8NCOD+c+xkxYFNkC3b04W/X4g13?=
 =?us-ascii?Q?rwYCPXqx9tpXYfCchtQtyzFJyJ66q8QqFP79VdGAH9FHVSDwkUqCnVsTvLUi?=
 =?us-ascii?Q?o8oH8L/gU5u8UdGNxt4m8DQZXnYSFx6XdwtLSbJ2F8CSCc6OGToNVd8wXOI3?=
 =?us-ascii?Q?LqldBnxm/jYGK8n21WSRbg6J3LJujorgFE/vr6O1a0BnaeSYYLRP4KAC5Tkk?=
 =?us-ascii?Q?HT7TBm9u5csgSVP6HmmWD3uCk3yZwqx+vHNMz2nJu1w+gj/ljHwdrejX0U3l?=
 =?us-ascii?Q?jj0xLXY33p3K+7w1sA+Sx+hdsgJQ3jEbmf5xWj4iariKV6lh9hgwrPSpc6Zy?=
 =?us-ascii?Q?y/uRkPsjXaJ8DjPGoovFBUj+QxyQjAAgZweZ0KF4Qw+AUACV0u7XAntCIJk2?=
 =?us-ascii?Q?cgtZDWMgQ3NNxVxsd167q8SQbPqMt52psCFx/EBEqA0at+FRxV4PNQWjJpwQ?=
 =?us-ascii?Q?/P+Sto1Uwju87ib4+Zf46iHMCcOAXuMZJFSjh4EFaBzklBcUJAL/PSSQAeyb?=
 =?us-ascii?Q?d9TVXhkcmwyk5pj6qZaWDBL+4em0wdiIhv41zyKka8v8qvq7cHily6t1ET1g?=
 =?us-ascii?Q?J9voFeUkWivklRwuvJqvxj4mh3Xy5MpgsN47Ym16UFDoIWpXt4Jb126Ayb8I?=
 =?us-ascii?Q?b0JVw7tBrWU8G0v4ZuJNuvq7zZtcJFu+2NC/7SFW92sFH7rCxkNMOpQf7SUy?=
 =?us-ascii?Q?720JWIiOOAi3JgkINVvyLPYJ8v4/8gmj58q2efxuQvP5xtCBDqd1MP+hCfGC?=
 =?us-ascii?Q?PFFJtVsZ40Hg2ePai0f5h3Gp2IAOUkIFIB9pfTivC98sF5BWSDyqIIha0DxL?=
 =?us-ascii?Q?i9b3qfbS1Y3OsHY4gcs7+mtm9XBa6N7rxf142dFPw6nZfjH5E6YhFAgeMVZI?=
 =?us-ascii?Q?O81O3VetfFOamIIUE5fJ+LzL3kLomMfnuyjehvQ9GKgn3xw82u/iwQeLFoWj?=
 =?us-ascii?Q?wi/Eb5y/xmMOqq39uHxFrWexGcNJ8TQ/wvWeMQhnQIzc0UtBHuwFClflYDRN?=
 =?us-ascii?Q?fMWfe7ujD4SRHd+IqtrWBGqGbVRaaE0OcOYwmTD+v3NRjZjnjAXSZnF+rl9w?=
 =?us-ascii?Q?VMYmEU7LXQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d807292-be38-4858-c26c-08ded0f826ea
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:22:16.0102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CQBtcz7abqnCxKWkTNbzTATPr8bYkM/+5I7eWRYDB6IT+A2BAW8F47peIcubyv6MSMKo/VTNXg0PpT8beCFfTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7990

On Mon, Jun 22, 2026 at 08:11:40PM +0800, Alison Schofield wrote:
> On Mon, Jun 22, 2026 at 06:19:00PM +0800, Richard Cheng wrote:
> > On Fri, Jun 12, 2026 at 11:16:00AM +0800, Alison Schofield wrote:
> > > On Sun, Jun 07, 2026 at 04:13:45PM +0800, Richard Cheng wrote:
> > > > The kernel now allows committed HDM decoders of zero size so BIOS can
> > > > burn slots with LOCK; cxl_test needs to exercise that path.
> > > > 
> > > > Add a mock_zero_size_decoders module parameter (default off). When set,
> > > > the special endpoints under host-bridge0 (cxl_mem.0 and cxl_mem.4) commit
> > > > decoders 1 and 2 as zero-size + locked above the decoder[0] auto-region,
> > > > mirrored on the parent switch and host bridge. commit_end then lands on a
> > > > decoder with no DPA resource, exercising the new enumeration and
> > > > poison-by-endpoint paths.
> > > > 
> > > > Gating keeps the default topology, shared by the rest of the cxl suite,
> > > > unchanged.
> > > 
> > > Can you add a unit test case for this?  I think it makes sense in
> > > cxl-topology.sh. Perhaps before or after the work on the default
> > > cxl-test topology, load this new topo up and validate the zero size
> > > decoders are as expected.
> > >
> > 
> > Hi Alison,
> > 
> > No problem for that, but I want to make sure you are talking about
> > adding test in ndctl right?
> > 
> > I'll send v5 within this week, want to make sure they are ready
> > together.
> 
> Yes, I was thinking updates to cxl-topology.sh and now looking more
> at this version, cxl-poison.sh.
> 
> I only suggest appending to cxl-topology.sh because I don't see 
> any other 'work' that you want to do and verify with the zero size
> decoders. If there is more work to be done, than add a dedicated
> unit test.
> 
> The verification for the tail mappings appends nicely in cxl-poison.sh
> but frankly, I did that before I looked at changes suggest for v5.
> So take the appended diff suggestion as possibly useful, but maybe
> out of date:
> 
> diff --git a/test/cxl-poison.sh b/test/cxl-poison.sh
> index 49aa1b68c5c1..b40c896a0903 100644
> --- a/test/cxl-poison.sh
> +++ b/test/cxl-poison.sh
> @@ -361,6 +361,16 @@ if check_min_kver "7.0"; then
>         run_unaligned_poison_test
>  fi
> 
> +# Assert poison in the unmapped DPA tail is still collected when a
> +# committed zero-size decoder sits at port->commit_end.
> +if modinfo cxl_test | grep -q '^parm:.*mock_zero_size_decoders'; then
> +       modprobe -r cxl_test
> +       modprobe cxl_test mock_zero_size_decoders=1
> +
> +       rc=1
> +       test_poison_by_memdev_by_dpa
> +fi
> +
>  check_dmesg "$LINENO"
> 
>  modprobe -r cxl_test
> diff --git a/test/cxl-topology.sh b/test/cxl-topology.sh
> index 170c9caf840b..aee675d3b7fc 100644
> --- a/test/cxl-topology.sh
> +++ b/test/cxl-topology.sh
> @@ -269,10 +269,46 @@ do
>         ((count == 4)) || err "$LINENO"
>  done
> 
> -
>  # validate that the bus can be disabled without issue
>  $CXL disable-bus $root -f
> 
> +# With mock_zero_size_decoders=1 the host-bridge0 endpoints that back the
> +# auto-region commit two extra decoders (ids 1 and 2) above decoder0 as
> +# zero-size and locked, mocking BIOS-burnt slots. Validate that enumeration
> +# does not abort the port and that those slots appear with size 0 and the
> +# hardware LOCK bit set.
> +test_zero_size_decoders()
> +{
> +       local region target_decoder base burnt size locked
> +
> +       region=$("$CXL" list -R | jq -r ".[0].region")
> +       [[ -n "$region" && "$region" != "null" ]] || err "$LINENO"
> +
> +       # Each auto-region target is a special host-bridge0 endpoint. Its
> +       # decoder0 backs the region; decoders 1 and 2 are the burnt slots.
> +       for target_decoder in $("$CXL" list -r "$region" --targets |
> +               jq -r ".[0].mappings[].decoder"); do
> +               [[ "$target_decoder" =~ ^(decoder[0-9]+)\.0$ ]] || err "$LINENO"
> +               base="${BASH_REMATCH[1]}"
> +
> +               for id in 1 2; do
> +                       burnt="/sys/bus/cxl/devices/${base}.${id}"
> +                       [ -d "$burnt" ] || err "$LINENO"
> +                       size=$(cat "$burnt/size")
> +                       locked=$(cat "$burnt/locked")
> +                       ((size == 0)) || err "$LINENO"
> +                       ((locked == 1)) || err "$LINENO"
> +               done
> +       done
> +}
> +
> +if modinfo cxl_test | grep -q '^parm:.*mock_zero_size_decoders'; then
> +       modprobe -r cxl_test
> +       modprobe cxl_test mock_zero_size_decoders=1
> +
> +       test_zero_size_decoders
> +fi
> +
>  check_dmesg "$LINENO"
> 
>  modprobe -r cxl_test
>

Hi Alison,

Appreciate for these, it really helps alot.
I'll start to work on it, at the same time I'll send v5 before tomorrow for review first.

Best regards,
Richard Cheng.
 
> > 
> > Best regards,
> > Richard Cheng. 
