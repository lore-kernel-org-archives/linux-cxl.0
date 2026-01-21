Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010006.outbound.protection.outlook.com [52.101.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37F13D332D;
	Wed, 21 Jan 2026 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007514; cv=fail; b=Tcg7ZvMh307dHGjnYTvQKliYvGqQClqv2Kcm4u+Sbe4lrIWkErFEcHJtz+gVGpTH+hMNCbtm+F0zd+qEgNOa0xiSH30YMJJC2wxgFF5h4PzIjkWC54h/5kmExvn2SL6InvdNjR3diKkr+3vUNVO5riY2SbVN//tcgcnlPiG9XpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007514; c=relaxed/simple;
	bh=zk1Slr/FYGfrwOajJpkWtfasesPOWDeLF5uaNXEJhnU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nQCV/umz2I0tX+iu7YFy3FlmeRIf8U9PGlNQKfZpLq+j+ztkIJGNatZ40kk+NidH52EmmQoH9e9k10RXq8d7XeNrkJm90epd9NS2PWbFatAdmrcH9CfmJiLrfnMiiZ6OLqPaotHiPIGEUbR2CaAdQ7iODcpI7Y2en1qW4X8vFg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bjtR4sUc; arc=fail smtp.client-ip=52.101.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bjtR4sUc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qzdli/qiVDRLkGGK5wTVikzsLJIhwlBn7XTXIZMh5JGOXxTWZFGXCUM5hoWfg+R8+59IOYLdez1Xu7o6Mi5KWOHo9tnhe7MVGMa4P4/ppI27KcgntZvFyCKJwRuIl7Qq3UBYa8mDylrqTqdwFuU5Y6cvA52TQSXWNIFv791Kxl/+Sfbu9ewyuKCJxXpD0MYKUFVgjdf6x4osO1pEUI9R2XighZBNcn6br80lRhFcTazlZ97OGIGyYf1jEKlT20h5NjYPbd05O2IgomGn7sHgUYJRV7imOOusMq7YFuSNhCKWynoIhkK+/jpn9yrnVdeBPYK3egMkUUJnNWBtd0iBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vIBtzNpbWkK1Njg9RYuubGlUyyISTbSFp/jyEXe0RrI=;
 b=hZcPFe6553oldiMSirkaqRdK4kg55ppLzOXzMoV6x5zVsu/X4VAwspGGLu7QUmyXFfwUDWHMNrDziCkNxH5f0QD7Sg5phVsR1lAwKxny9YJOkHOwRqfVb/MHNSdj5vYh0vrXopEN2yk6c+DYztBpvdMt+/yMlbNsXGIpcA9ECrbrg4yZNaaf2zPHF3vBObelor9WA6ztcsbQD6czWWcbcd5pZ9zQbpTWL05OQ0d08UT5TF0Gp/UaRZUbmL/GFzfp+EBYlMpk9teY8ushrsk9d8Jye70W+Pf9MigpUaT0V6ZTVFKfNa5kFo79kLuC87q15YPeSzG0VrpwF741qORCcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIBtzNpbWkK1Njg9RYuubGlUyyISTbSFp/jyEXe0RrI=;
 b=bjtR4sUcp7juPqlblKzVrpkvCY4M2vnWd1f1bnC83hZ8inOiAQY+r4wa7UyMT0Juigu3O+V1BbZprmvPjlBYhDoShI3nmd2Sa0iedpi6Jt59cwusAgNiiZkfz5iq0uaT4cF4tuNcUXUICg+TTzUOE8ucfyf9v+orUg+2x0I04cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) by
 SJ2PR12MB9114.namprd12.prod.outlook.com (2603:10b6:a03:567::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 14:58:28 +0000
Received: from DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f]) by DM4PR12MB6373.namprd12.prod.outlook.com
 ([fe80::12f7:eff:380b:589f%6]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 14:58:28 +0000
Date: Wed, 21 Jan 2026 09:58:17 -0500
From: Yazen Ghannam <yazen.ghannam@amd.com>
To: dan.j.williams@intel.com
Cc: Robert Richter <rrichter@amd.com>,
	Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20260121145817.GB1784626@yaz-khff2.amd.com>
References: <CAMj1kXHYTyxBcO3Jt97pukZiOTqL8U=zL5iari82sqMOen1cEQ@mail.gmail.com>
 <aWehZwXsK1IXRNU2@rric.localdomain>
 <CAMj1kXFhBdCPW_+xPR-TmU4M46Jr6DGwtjUtjDQ0EbgPGmL7vQ@mail.gmail.com>
 <20260114180859.00004623@huawei.com>
 <20260115080444.GD830755@noisy.programming.kicks-ass.net>
 <CAMj1kXENYZq-UkCup6FSH_4tmpRe4xJN1_veuSWs-hxxAo=1Ew@mail.gmail.com>
 <20260116143838.GC1890602@noisy.programming.kicks-ass.net>
 <aW5AvfcjLkSP2j42@rric.localdomain>
 <20260119160342.GA659351@yaz-khff2.amd.com>
 <69701f6de978_1d6f1001e@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69701f6de978_1d6f1001e@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: BL0PR1501CA0007.namprd15.prod.outlook.com
 (2603:10b6:207:17::20) To DM4PR12MB6373.namprd12.prod.outlook.com
 (2603:10b6:8:a4::7)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6373:EE_|SJ2PR12MB9114:EE_
X-MS-Office365-Filtering-Correlation-Id: 100cff00-3b18-494b-6231-08de58fd88db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a6Dlajg17GDCRCVPMpuLw1n6Fm1GpecBdF8z/AshLjy/wJSfLkrF7N1kHnhg?=
 =?us-ascii?Q?X2H962QClks5AbURUP7MphJLERgW8eNbb1LnR9hpevcsTYGQ6jCCfJFlvAUY?=
 =?us-ascii?Q?B2RW5Ch3xMjuTONpCuT1T7BIPI07AvqK03xvHIMcVwv7KHYUvIzl3lDkQBzc?=
 =?us-ascii?Q?an497PyuNrY+HZfNOljtL5DHukqztrwx5lhi8jUubSxkBY4rgC2ETcnuk43P?=
 =?us-ascii?Q?Ux5TbRbkf37FymLrOnlmWWQUru+4kN0AbGUZKQALNnK7ujjzGfYwreU0/KvE?=
 =?us-ascii?Q?XqD+nKZz/wVkpchPuAi/RWA6MKHyWcok9Snsgi9vhicHU+53EnBdnFotpAam?=
 =?us-ascii?Q?mPdWYw2jQcwNhxvWywdICbMb4fd23+W4Wy32SUgc5tkMcqEh2xKd8BN9w6+u?=
 =?us-ascii?Q?9oXefSq1bfzTKxDoJZSkhAZm02t7jrvHKFwkN7NdFJQTcTT5ZNRjMlqUXO0v?=
 =?us-ascii?Q?li2TyFxyNSUkJz2TFWFSS0jORGULEJo3s/Uqd46LcVqvmqZTcKsWSnmrD9Fi?=
 =?us-ascii?Q?nqiqK1DDIqtDgyyh6MqQcLcc0t/94nD8GbYyEm6Fk8zJxwc7n6NifqdpKLmG?=
 =?us-ascii?Q?oyhtGcpwnpFX13G2WhiC1Z0loN5XdQjAHOPBz2FvV6uk9vSjGc1ix5DOOnfQ?=
 =?us-ascii?Q?IWQCqw2g9HuOhqjI5BM6AwRClelT5F7riQAZlOKZ4Rxn0/hwTpH7z+uNHCTd?=
 =?us-ascii?Q?YpLi7mj1hVm2neTa1C4iNU/gSaKa2UN94cRWb7taGAA16UZTbk4HpuhNmxsj?=
 =?us-ascii?Q?VuvK3TJZsKDJs6Oca6U2vlJLOjTijVwoN/xdxeL12VPhCufrzLGt2iaHjglW?=
 =?us-ascii?Q?/pIzY/VaGgo2Oo6SSwtcsMS3eD4LdL99PNPGZskwDpivblgW/u50Nw6xSxi+?=
 =?us-ascii?Q?DJ1UbL/va+1g/IfbkCndWrNhzy8KAwVdT/xepVmoTtqDlqui+MOk+JklzV2j?=
 =?us-ascii?Q?BWQg2Nb+X0NRg87//7wMHvfie1+sj95NqyAXSiXhU0VTzzrl/SHdoEMAcygL?=
 =?us-ascii?Q?Nfl6cmi9opO740m6fpsUZulio7aaIQbi1DK/pWlRwIlnT+aICu63+YxpWUxL?=
 =?us-ascii?Q?tWTwyLBaE4P45ASZJ2g/Yg86frexTxkvjb/8Ntkhd4mgm9oI5kaWwPDJy9BI?=
 =?us-ascii?Q?4eOHNMiZkh+XXH6LjGH/LB+xXbMjeo51l10qE0n+HjPIY/VBKCIOEc9uXI7T?=
 =?us-ascii?Q?4sAZK7BFzmkpvWm1obq1AmrnOq3V0SXtr97CeB+Z1sFu+TGmkFUCXjx/gr/y?=
 =?us-ascii?Q?N4zJ/mhLQLFIu96ywnb7sNHoeYzdEFTq55iLSLXEj17LgZYJChl5sDRJL+HS?=
 =?us-ascii?Q?2nkRzcnkrwuIUHdOhGquxD+gnG9HQ+215xZma1S56P12C2wNd0fwafouKUJW?=
 =?us-ascii?Q?MkfKlZf8ziydZ1FBszIbc31y7VBYePLJxMJ1RrHBzj8/9mbnpbkGTiBelge8?=
 =?us-ascii?Q?V9NoNtXshMcrSkNTGCNgWyxzNkl+5CEjeBuCBBzkXms+JUp90d9WAMug0rNR?=
 =?us-ascii?Q?gq/Dl2WweIXc+eMHYLmgaIcHxF301HVoR6l6u3/pLyoYxzXSbgBjAp2Rhn0+?=
 =?us-ascii?Q?POz3LJrX5NIz0lajswg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6373.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wCfH6KX3Lq1stIr6JIIiOhz9ltWa9KFiwDJrUaBZBabGs8MuBno5BIUf4hDy?=
 =?us-ascii?Q?1JFX+AapsaWcjbfvmc+8/P9hV8dciTG/GjWDk59k/fwKM8xoUYJSUzy+7AyP?=
 =?us-ascii?Q?zITp41YS9iSk+5IbyFBwoF0hLIpk5MVLEOZ4APHknWbIQfXTQj3f4CKLgf5h?=
 =?us-ascii?Q?0LlDDtpCrYS8uf3TnQ+aiwpY/B76gdS9JCsaTvchwHzFkgqU1g8SYdOhJIU/?=
 =?us-ascii?Q?3NUsCIVFuqjvum69gOf3ejBFZceN82TJmlhBUwz9EIwG04LS7yLDDR1qhas9?=
 =?us-ascii?Q?Wys7yp7Uw1186Bb9XYHoDB8wjEwxkDXypAeKYGn294qb/LCKr8nUWAHXV5zN?=
 =?us-ascii?Q?N4K103607QNTpEaCay9R1wZgUSK3sHqW2RvS/q8LoTFmh0tBSojYQhMCVvtd?=
 =?us-ascii?Q?5XP1705z+tRSvgUph5Ac+sbp94NyVOZVGW7b7PQgqo8CPNNzMevkNhrwqOzc?=
 =?us-ascii?Q?G3Km5YnSpDavPyksqiVf+rARhfx39P8gugT/d0FZI/YUFWaMmLzM57QWOdiG?=
 =?us-ascii?Q?DeA8B0ru2seXAed1myHiJ4MK4W20uMnxTHrRXCtNnWxSgaCByJIY2xPKvaqQ?=
 =?us-ascii?Q?KvIVygw3oZsRPXGFE2ZIzPxnoLQ7ztu9oNc8QzzeiTk4jOdQRDj9Oy5dXzQu?=
 =?us-ascii?Q?32aATKqujBvAz8ryFYndfBwk5iS3mQtt8JG3ONZBjn1fiPUmrCr6R0tz0XQ2?=
 =?us-ascii?Q?3XyfaGQlrdu1lbsi2A0CTtDQvkXTsMisnJYEK3iNMeguXYMqb7JigwA4R+Ez?=
 =?us-ascii?Q?T+5V2Na0tnxs7z1IlFHV9DCnvpYzuD7LI14WUoHI2+pG7nNYo+RNrKvsTZLp?=
 =?us-ascii?Q?L4loQD1UnA5BI371IaJjXBys/Dz+MmALcu1nakPCxhXPQmIii5vi621odHfx?=
 =?us-ascii?Q?FcjAEVu7aAzEQgzcCkALlepYKyMTlUSo8taZvQRxIMoDTb9PWPh3S8SU/Bd0?=
 =?us-ascii?Q?BcziHNY73B4uA9/2TgXqU1iAcxYp4DE732mUrXHoRybqdYWCMvx3Hc87bhM2?=
 =?us-ascii?Q?1ezychJRxZM566sMt6ipbR1fTfJvUr++fVFsA3A/Nc+fEg2BIStqgCgU8/rC?=
 =?us-ascii?Q?8pGzWqh4Ucu+CVtbVmhcs5xJtJq5Gogxu2kMzt/w8xqf7Ipj2CublTxKARAY?=
 =?us-ascii?Q?6PxUlmT4aWQP9fpw52hyO/nmsw9xqNY1yLkZavD9lQ2ayfi/J36NDwjFNalk?=
 =?us-ascii?Q?SjblmEb8CXRtgey1J2Sku4qYkBmslH0mkebc+OEIGF6B0qHeR3NfpYo+ty5v?=
 =?us-ascii?Q?H9cEp/PYKfxcGRdYkANwdo+c8Rv2hm1Wwg/8GVZtZOHD7PqCtzdPmkLjEtG+?=
 =?us-ascii?Q?VpRowaykE6IOCaIyO0tzf4SpPujB+0d7o/ZS9JsFpOkv+giUZvVqP6H3nHzN?=
 =?us-ascii?Q?IzVFcw+yG93+NcR8L11utFgJsB2s1gHlMK6z/cGfi7sRonpmLtHRF9tUqt9W?=
 =?us-ascii?Q?/8bndHJ5wPdZFK2OPbXAXJGL6Y01cqK9P+X+50Itl+2LdcJNKDXjNfrdLEtq?=
 =?us-ascii?Q?oqplLffkKejCqL2ZM0lCS7l/Ny7RZaNOp9V/FMP3977HM3djBfsIyZASYDit?=
 =?us-ascii?Q?OtsIBXffPUwsd9PTZb43T5+S56txsn+/owUklXmKXUIqaHqNbb19isR1pWC9?=
 =?us-ascii?Q?qaRILWb73Jy1K4uh1PD1kXuHZAVwVSIZ857F07pjvEWU3TTanQGtHKPE8nNV?=
 =?us-ascii?Q?oAFtG+XkDLejY6njBSphZJF5cN37CVLxR9HKedP1+E5Glmy98S6t3CNVDsjQ?=
 =?us-ascii?Q?l/iX742rmw=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100cff00-3b18-494b-6231-08de58fd88db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6373.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 14:58:28.1509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOVhUleaIBHH/b8QK6LjWZz9EokG3ywDbzOWA08kqzkx6RUCjVGSKwVPOHptGiLzjlWaPRXYvlq3OHiRNwE32Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9114

On Tue, Jan 20, 2026 at 04:35:57PM -0800, dan.j.williams@intel.com wrote:
> Yazen Ghannam wrote:
> [..]
> > Additionally, the same translation code can be used in multiple places
> > (tools, FW, kernel, etc.). Most consumers treat the code like a library
> > that they include. It's coded once and bugs can be fixed in one place.
> > 
> > However, with a native kernel driver, we have to re-write everything to
> > match coding style, licensing, etc.
> > 
> > Also, new hardware may need changes to the code (sometimes major). So
> > there's upstream work, backporting (more testing), and so on.
> > 
> > See the AMD Address Translation Library at drivers/ras/amd/atl/.
> 
> There is more nuance here.
> 
> There are indeed cases where there are high degrees of non-architectural
> details in flux from one product to the next. For example, the details
> that EDAC no longer needs to chase because the ADXL DSM exists are a
> solution to the problem of shifting and complicated memory topology
> details.
> 

Right, this is the intended use case. 

> CXL is a standard that this architecture at issue decided to inject
> software-model-destroying artificats like CXL-endpoint-HPA to
> CXL-Host-Bridge-SPA (Normalized Addressing) translation.
> 
> A Normalized Address looks like a static offset per host bridge, not a
> method call round trip to a runtime firmware service.
> 
> Note that there are other platforms that break basic HPA-to-SPA
> assumptions, but those have been handled with native driver support via
> XOR interleave, and non-CXL-Host-Bridge target updates to the
> ACPI.CEDT.CFMWS table.
> 

I see. So the concern is including model-specific methods that would
modify the CXL standard flow, correct?

Or, more specifically, is it reliance on external/system-specific
information?

Or the time spent on a round trip call to another service?

> > > > Worse, you might have to deal with various incompatible buggy PRM
> > > > versions because BIOS :/
> > > 
> > > The address translation functions are straight forward. I haven't
> > > experienced any issues here. If there would be any, this will be
> > > solvable, e.g. by requiring a specific minimum version or uuid to run
> > > PRM.
> > > 
> > 
> > This is a good point, and I've brought this up with some of my
> > colleagues.
> 
> The more that software bugs leak into this interface requiring
> consideration of versions and the like, the louder the requests for
> "please move this to a driver" will become.
> 

Yes, ack.

> > The PRM methods are supposed to be able to be updated at runtime by the
> > OS. We could think of this as a similar flow to microcode.
> 
> No, at the point where runtime updates are needed outside of a BIOS
> update we have crossed the threshold into Linux actively taking on new
> maintenance burden to enable hardware platforms to avoid the discipline
> of architectural solutions.
> 
> Microcode is a confined solution space. PRM is unbounded.
> 
> Now, stepping back, this specific Zen5 support has been a long time
> coming. Specifically, there are shipping platforms where Linux is unable
> to use any of its CXL RAS support because it gets tripped up on this
> fundamental step. I would like to see exact details on what this PRM
> handler is doing so that we, linux-cxl community, can make a
> determination about:
> 
>     "yes this algorithm is so tiny and static, PRM not indicated"
> 
>     "no, this is complicated and guaranteed to keep shifting product to
>      product, Linux is better off with a PRM helper"
> 
> ...but still merge this PRM call, regardless of the determination. Put
> the next potential use of PRM on notice that native drivers are required
> outside of meeting the "complicated + shifting" criteria that indicate
> PRM.

I can give a general overview. The AMD CXL address translation flows are
an extension of the AMD Data Fabric address translation flows.
Specifically for Zen5, it would be "DF v4.5" with adjustments for CXL.

The "DF 4.5" translation is upstream in the AMD Address Translation
Library. See code examples with "git grep -i df4p5".

I would consider this "complicated + shifting". This is true for general
memory errors reported through MCA/EDAC.

I defer to my CXL colleagues if the "shifting" criteria applies to
future CXL systems.

Thanks,
Yazen
