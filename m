Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E50264FB5;
	Thu, 13 Nov 2025 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052303; cv=fail; b=azWKrZTP5ZGaBbfCnmDnw4gc0q26QEEgd3VY637loIbf33ymHORwYtRrgff7Il6evmWsR7tTC6vN7zTWktRJ3HUcSuL/5ZXAXqnLtEjcIixrenxhnIJceX3K6eiSJb4/9iPcLWPtiGjiuVihd+dNRpkKheZqXfuoHzBKdAtHOpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052303; c=relaxed/simple;
	bh=8ZEqW1AMZx6QE915UTzHjEqLr3DY5yfVJqgd14vuv9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RW2gpRgC68nsXnIOi7rdhwtxQA/YiBseOhg40QBbliEyKgEesJdeYZkQcaekAiAnfSbhN3eHndsJhUTKoSkqZ3K/gHDZh3G4H065GCcFfjji3MxrUw7/Tv2nbZL0CD46sM85f24MQi6LdTLhMA5DhU+n3953uvnlfU5w/TRjX/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ghjxyIz3; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ghjxyIz3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpsGGrQItrdcMjk39vHwL3xA6AVUwgYF4JzXpTgZWyBMOHEY9C3Hou7q+gTDDH+iekc01BgXei3GQ3MMSxlp4oRF42JQh82XKbzKL76G4UwjZAgTrBxk5gwaZ7IYuJobUXntJXAMdnoyKJkkarkR6vyCKYwXx3uRw+cFvZdhHvqy7Cdp8umqTgyT76LmTEzDzDCb3IcyAOBlLJ5Unj0cjW51JcjGfwxSYsVE5msFgxDow8nJ0hvTh2F2ZKPxOQZk1fhtk8BHQ1wbPlnf476EedPpQ4PXBFZsMpVkrdG2hKcV5x2Z8Z85bivSEtNqT1+e5laCcTVb5HX7KEqNv1hFxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mdBLE8JTyKFSBYMzgeNEvAyEqFROy7AP/yg3zKAz/Z8=;
 b=umyP7cyP50px+7CDS6hFNwY+51H5Jkrrgp/d4EYTjbl4oI9HFAEy6No2M+AeQ81L6hZ2s56vRuE9XiqyYqDAsgw7LPXOjje3kz8syAN9KheMa2QGTqfxPsZZpps3UI8U2Zef8BRyX3fJhtJZAJ3tSHDByzIkp2HrNQoukUAb2kwtrLR5BlEEsOg0hfLE/K/7RQH/ywo7f6WFKeA8wTiJ6xwRp06y5dTRWCPiOhaFJ14SXCbGDV74B3nqpnMvz7+CkSRorShlTw/9r2pAT3amDgsFbZcjdg2iUkaCpgARQmjPtBZafKjNzAzTEYGOZNaKjAltt2blfTjU1diA6W8qfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mdBLE8JTyKFSBYMzgeNEvAyEqFROy7AP/yg3zKAz/Z8=;
 b=ghjxyIz38oMdgAU6U/dtO+ckIjdSIw4EdwCTHlNxydL6sXsTUZ+zeragP9KSz+0TvMkItGTaDjELHwKzgIs4Ns+YzeJagjuuopEryQ08Pa8R4qRUPXsSj5SXvMQHAV0I8hZnJyMEXiOYTMotHEdOo3XPKOFrEo9v9OK+p/GOyTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DM4PR12MB8450.namprd12.prod.outlook.com (2603:10b6:8:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Thu, 13 Nov
 2025 16:44:58 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 16:44:58 +0000
Date: Thu, 13 Nov 2025 17:45:26 +0100
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH 0/3] CXL updates for v6.19
Message-ID: <aRYLJmjBsggjzA99@rric.localdomain>
References: <20251112205105.1271726-1-rrichter@amd.com>
 <db9e4d27-057f-4bf1-9d74-008ffeb0dbc8@intel.com>
 <aRW6h127k5Tzns8R@rric.localdomain>
 <f0285498-810f-44aa-8577-e28641e97d56@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0285498-810f-44aa-8577-e28641e97d56@intel.com>
X-ClientProxiedBy: FR4P281CA0089.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::18) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DM4PR12MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: bad5d7f0-df55-4080-2cc5-08de22d3fb04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yte/6YMSWF4R0RarD8UAslOXSc47ADYOWpZQlboKOmLV3ZIMxiI5ciGqxE0h?=
 =?us-ascii?Q?ckBvPmhc1T/qm/R9rF5mVDjj+jr2MpGwcpa0mPvqHgY73lK/aZs5sr5vDBEh?=
 =?us-ascii?Q?DNBxXfY4+zRWolxkX8ULFjY9pQ3it5rENbnr7BFjbZjj4DhhPVAbm3Kj7xtw?=
 =?us-ascii?Q?L8umqS0ynmPbEjKUttXTPUxUmcQUIKx0D6esf5c7dkSQi1b3ELeZ2DRqPl9/?=
 =?us-ascii?Q?zdljeBootND1te0ZBEkFFZOkogr5uqACUOPNPm1uv42bxlB/Z7e1jMQL8sps?=
 =?us-ascii?Q?AbPPaq7YdJu16gL+gC61c+9bbMlQbbSM+rzSxJk2MQnjfmHGj6fCxQWDYSSh?=
 =?us-ascii?Q?oE8tnEz95qOOpb2w/qTNgsXj5013gCfoHT+EuTihu6wNdK6HdW9W6uIaDmXv?=
 =?us-ascii?Q?hb7hwpqKCFHSGso7rPzunUc7GJtUD5CZyZ39FCidhNl5gaGuCiTeb9CzOK0c?=
 =?us-ascii?Q?cpYuwX0gl1Zieu20YdaoJFeHztHld4G1CSD/mTiBB7sryzwGBXXKghgXuhhW?=
 =?us-ascii?Q?nv5e+9lw9lkPQJFFzJIUZ0n1TIGTVQaOtICVHuOQa8NBy0JwvUxgFmHwXCPT?=
 =?us-ascii?Q?L7MUJgBq9riVSMTpGVO1mJQkfmthS+3vckGnxnrYDfG7vE+9RiLuo9X/b/LH?=
 =?us-ascii?Q?U2TgR11IBj8RJiGh53lQ0m8Bzcmv8GuECzMpXitqFoM1Y2WqdPJpSO+THXFZ?=
 =?us-ascii?Q?SBGc8LIbwlREhbisRBge49Z3Y1qrdrv92NCeiCWHrM3BL4HfNjy5RTzfKeC8?=
 =?us-ascii?Q?NcMG+C8YG+duBg/HMiQ44lYHgzjWKyTvC6pGgOWgVFr3OpRraCp4iKT2sbUM?=
 =?us-ascii?Q?zF1HGshANAIdxKcRfY1X/xeK5MCpeb/py38Wph1TFEathWAAtuy1SzUV0umd?=
 =?us-ascii?Q?FAVdGkZRuVpKwHGBBt92BQBjmtrz+5+CaKWutCjS/F7RpXELk60TcC0GPDr3?=
 =?us-ascii?Q?7aT9WIG7C5gziIUhVFtzWLzk2DhSItHs8ucWNARpeaKA3TdHLg1D/Q1iwzP3?=
 =?us-ascii?Q?iNuWZAb8oiCTdgDcv6IRSWqzh5f7Mk6nqfRH6c9G1xotFmUAcERkI6uAbRbr?=
 =?us-ascii?Q?FNJ1+GRrzJY9linblJ4kxTqKQh0cuBY6prx5p2vE7LioPBIygUZt92Y7pZBV?=
 =?us-ascii?Q?GR5Ap4eCnj/vsYUyt8/Z50OfQVz5hzQwHzgDc8THGzQQow1nTYs7tNhPQOe7?=
 =?us-ascii?Q?O3QGNkoEn2W1OYGFl7GNGEfRZwjgXPoizJEbj1BKvul+pzuT2YD28w43rBNt?=
 =?us-ascii?Q?Gyu1mxTTsPqRnYzOM3GBzb+OYhXlISmpggxgC24FlHjPKrcCJ3qJgBJ+3Iup?=
 =?us-ascii?Q?t//f1fvUxR/9r5g85FJ9NdvjkMG7A8jmBRD2C6BrLFX5TzrOMFiR0UthfosL?=
 =?us-ascii?Q?NCL5Arf3Yw4dzGWj2hm7oagcvpIaTBGZlOmhl3W74oInY7ke/rvJLxRsAxS5?=
 =?us-ascii?Q?1he+DDpibs7brsiO1F1SgqlB54ZHSJGU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?f5UqP5rJ75VNcBln/128UDHb8SSu+2rQxms/tkMI9+ocrLbbjAZzdxt9TcfG?=
 =?us-ascii?Q?mtXVIYUnKax4OQm/ngNeFlu914H4Comr4W5dbkHWecY3IgRoLZSE2KfecysR?=
 =?us-ascii?Q?tRI1ai32jfC9B02uY0w7W5b3fIs0HYhAyQOV7wC56056+YA2I2jUaYKKNZin?=
 =?us-ascii?Q?HMczCdzcqi6qGsUouv/WAzxnn1QUae68KIqIGbImuvjF4QFfFJE2D3edA++E?=
 =?us-ascii?Q?RouwlHIxkRgVgqKdHhmFENxgQcfpkCGSeL7v6mx6Kmz67xKE7EGwJs2JIDNa?=
 =?us-ascii?Q?uGdP5KoapN6X/8zAcgb9C1mVgLhRUUkwfMdSHsgOdBJ4+QKp3vU/NPbEXA52?=
 =?us-ascii?Q?5NBbj0y6J3WWVNXESDJ177yQoxEkAKI7R2awVuvKrLA+IPwJIQaJ9DO234Wc?=
 =?us-ascii?Q?/qz+aT8lPTmWz/Bfo4xhiWu9MGMTdB3jl/3VLtJvf3WjzC+q4P5sS0MW01Jy?=
 =?us-ascii?Q?wpwWftT4PFgENNLNZA/8zbb3cz9WW8EZ+Qx2NRTX+q/AnbumNNsJMqefPEUh?=
 =?us-ascii?Q?bu6o7WDGEtTGg07oOBjhT3dIPFbHQXVgUXawRrgtXs7suNVQrO63UC4yV8cT?=
 =?us-ascii?Q?jNuhneyYRGtW08crc23kVso1Np8O3mwVLei20+rtuAlIXP+BHCvN31msd0tu?=
 =?us-ascii?Q?BjflN+Fa1RqVrUXNSkYZ1dOmXvnESg++9B4AfCluhsPZ2GwvYgiGf+y/Pr/o?=
 =?us-ascii?Q?Z4hhhSA6at8k6S0WwUYqghLpCRkZ5d7SZ3so1j+GMEiKxkDQsvgzbdbAEH3x?=
 =?us-ascii?Q?xVjY52qrg/YxZ+2xLgZg1fRCph7MgEvZghMX9C7xJOmQSnT0TqghmLw0i7yQ?=
 =?us-ascii?Q?t68F6/ukX9FSNWtLWBzSzqUETagYeCqk1Vu/36v5VOpSoujaur30Z91Sadqo?=
 =?us-ascii?Q?ikvip92HYkRp+Vqr2yjcCIxZaiO3oW2muytWyEsv5G5D6KiRQ+fWYVvTtyNF?=
 =?us-ascii?Q?h72bF/1Pv31UdrG8CV5plFg91LnTQ/HLP7/OOw5uQ6FCrLmOf0mWtAG+T03D?=
 =?us-ascii?Q?e5DufWtln+xVZ1VHJ4nmUJ5AmsW6MjhoIGG1tE4JzyyvHIbB17WQyZFQVGis?=
 =?us-ascii?Q?76roseaNJ8GqJkUyelVcYXmwZ569yT1bpJYkr5SZnqcnhvOTuLo68PcbwpKV?=
 =?us-ascii?Q?xjolVS+FItb+rENIw/uK5CXhWGTazpT9bA6lo1R2+DgBo+/gH3UpD3iTpPwp?=
 =?us-ascii?Q?p1PgfJDE+bQ3SWKH8Bk4joibJCIu/A/GI64nABjDDSRHZuxMKAj5LKaABJ1x?=
 =?us-ascii?Q?96BVo5LnhboMgvBUVgCMubKjsu4S4tGbJmlgst2edURYkQhLTGcZRYRaqqR2?=
 =?us-ascii?Q?5rXFLdRY6Qqm+/pnpTT19I9UvAFmyduVt7aWpfmfXw4C71bS1xAht6O1NhDl?=
 =?us-ascii?Q?hPg12S+suTzmBgWzwz/7cjkhbcT1WG/ua9oxkXjp1FcJBgcrwGJ3BhWO8EXe?=
 =?us-ascii?Q?3Kz5uh1u/bWqKzSr+n9Ssl9m35c8mjPfgqPGmXiE9uE5HTtO5GW+Qjd6Iq18?=
 =?us-ascii?Q?lEjK4Xnc9QlbpdyGPxCMIEpTLCC2zxhR8aGMTvc8TW88eX/Ev1yz/MZMlIcG?=
 =?us-ascii?Q?6gk+q9D4nmZu9TfbK5hTvsi96wVVM3r3CQKvR7g0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bad5d7f0-df55-4080-2cc5-08de22d3fb04
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 16:44:57.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YhlYNpm3gyOI9RLbCem6jzxl0JH3h2eymze8JfTGhsKNHoBT+6aCT2AA1PA5ilcclJmLn9JfZR9dRU+qNjFr1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8450

On 13.11.25 08:20:59, Dave Jiang wrote:
> 
> 
> On 11/13/25 4:01 AM, Robert Richter wrote:
> > On 12.11.25 14:45:28, Dave Jiang wrote:
> >>
> >>
> >> On 11/12/25 1:51 PM, Robert Richter wrote:
> >>> Sending optional and rather independent patches from v5 of the CXL
> >>> address translation series [1] separately in this series. The patches
> >>> could be applied together with early pick up candidates from the
> >>> address translation series (namely patch #1 to #4 or #5).
> >>>
> >>> [1] https://patchwork.kernel.org/project/cxl/cover/20251112203143.1269944-1-rrichter@amd.com/
> >>>
> >>> Robert Richter (3):
> >>>   cxl: Simplify cxl_rd_ops allocation and handling
> >>>   cxl/acpi: Group xor arithmetric setup code in a single block
> >>>   cxl/region: Remove local variable @inc in cxl_port_setup_targets()
> >>>
> >>>  drivers/cxl/acpi.c        | 15 ++++-----------
> >>>  drivers/cxl/core/region.c | 25 +++++++------------------
> >>>  drivers/cxl/cxl.h         |  2 +-
> >>>  3 files changed, 12 insertions(+), 30 deletions(-)
> >>>
> >>
> >> Hi Robert, I'm having issues applying to 6.18-rc4.
> >>
> >> Applying: cxl: Simplify cxl_rd_ops allocation and handling
> >> Patch failed at 0001 cxl: Simplify cxl_rd_ops allocation and handling
> >> error: patch failed: drivers/cxl/core/region.c:2958
> >> error: drivers/cxl/core/region.c: patch does not apply
> > 
> > You need to apply it on cxl/next. There are conflicts otherwise.
> 
> Hi Robert,

> I actually need a series that cleanly applies to 6.18-rc4. I'll
> attempt to resolve the conflicts when I merge that branch to
> cxl/next. Of course a resolved public branch somewhere as guidance
> would be appreciated as well. Patches should not be based on
> cxl/next. Otherwise it gets really messy when I have to drop some
> changes due to issues.

This conflict resolution was not trivial as code was moved around and
then modified. It will be error prone and time consuming if someone
else does the conflict resolution.

In the cxl tree the conflict resolution is most of the time done in
merges which causes a headache when rebasing patches again on top of
each other or when forward-porting patches to that tree. The merges
basically hide the actual resolution and the patches that are involved
in the conflict. Recreation of trees with merges is also not trival.

Compared to conflict resolution when doing a (hopefully rare) rebase
of the cxl tree, it would be much cleaner if patches are on top of
each other. There are no conflicts once rebased and you don't carry
them around any longer. I don't see much benefit else. Also, the
author should resolve the conflicts who best knows the code.

If you prefer merges, how about this: Have separate branches as long
as there are no conflicts with mainline and merge them in. If there is
a conflict with one or more branches, base new patches on top of that
branch or create a merge point to port the patches on top of that.
That branch with the patches in can then be merged into mainline, but
there are no conflicts then.

> > 
> > Additionally, patch 3/3 (@inc variable change) of this series also
> > depends on patch 02/11 of v5 (store root decoder in in struct
> > cxl_region). If you chose to pickup some patches from v5 first on top
> > of cxl/next, then all this 3 patches should apply cleanly.
> > 
> > Since 02/11 is one of the first patches and it sounded to me some of
> > them will be applied as well, I would prefer that order to avoid
> > rebasing and resubmitting a v6 for that. Let me know if you want to
> > handle this differently.

> Hmmm....maybe I should just take the entire series hopefully next
> cycle when it's ready given all the dependencies?

Patches apply cleanly on top of each other, there is nothing that
blocks.

Let me know how to move forward.

Thanks,

-Robert
