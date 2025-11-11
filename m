Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012029.outbound.protection.outlook.com [40.107.209.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEF82E8E06;
	Tue, 11 Nov 2025 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862825; cv=fail; b=mzNO8hVUUT8MEhQ2O500MZH4qKsEdcPYMibNrbARJtxxz0jq/y7WC8RV9H0C8Umbf2UwjRyDReXA2S/cqpcx+e5ooApQBBCfakoN7SiChbIVstT95096L6dW3gq5DUcLWT7BUV/LivPAH4dSlmpE8UsxZvsviv2A7pkmN8UAj8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862825; c=relaxed/simple;
	bh=ArehFifUIIBltgDLFXSP3jFYgBn4MJN2VOMNSEEsIBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CwcbeYUUrGPB0C5Tc/zwRegXU/SKBOskCSgFgF/N7uMsELGV8+AVEXIYo/NazPXVQ8ObVZg4s6SJkRzyXWxaBw4Hz6zpQ0Wuj0kgIKYXRm2D0DEri6h1Fiwi/Vxae8RwKBTsPimxjGwn3zKoJy/qe8gpWDt3bPgHoyXBe8m1Lp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LKUE9JAt; arc=fail smtp.client-ip=40.107.209.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LKUE9JAt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RbmTxDzaJLCEE2BI85w7nS/CBgqO4McP8YpokLEuOrdw84iPfXQfpK0kToYUVNs5GkvVHaQLcxkougmvH1XrXXhWUScnyKwKPSimIlHiYUqaWyvuoZmc8QeA0yZR1OTziHQ9ejo4aQIYEs+dgRn68ktS8a2fnRNzhD0+Eo+2aQ0LFDBLX9AGB5o57PWPCyB4M8H9G0W8vZwQbxCEQ2KkRnrxkUgZgVt2OPMHmkoR3pO19+efCGKlG1lw3lKHBi4Ecu2+fWZT+3EQ9gmmuEjl6mwWSjjsX3o+Nnd+TlfzuNqvzuw7FpZUt8mHgrBr2s/kyazksZoz1qSssaeAoYM3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLCNcztp+MVEhyZ+ch9sY16yzSqj2fIZmY5tlgLQI7A=;
 b=kc7jwhjmQmPWLkOJPibfYkUL5fnR49gwvmg7FXcErMzVp/HutiTlfFkWUxtuG00Gym0hLCVz26p4BZWMK7nXFxKnj78ak5EruaXAC5WhjQmkZ3Yahg24X5ADOTaSBJ2LlO0/z6TB5WQG7hbmYINPL2z7KROeDJha78CWwYSVxGnhUoT8KcDGP2ekrSuUHBnywlheGoxFS1k4TEyHgz4HNx0BHlr2vRNwDp9QP1HrHemK7jV8rR5UZhS1EkmaHODYl7Tk9GP1arpWMVq+3cZ+Vwq34i8QC/bIw0plS/grfRclY5xwUgrn8TbnqOIFZRAwOgyiwEXgwkMaMnOiZb3LGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLCNcztp+MVEhyZ+ch9sY16yzSqj2fIZmY5tlgLQI7A=;
 b=LKUE9JAtGowlC8D9hcHy80ZUxMYCPSR0Hw00/kIWJaK28nvHAn4yATrWIxEEwH6nLy2/EglA0V7PVyCN1CkTK7IyX2RO0mooIhde9uZfkDxF+odzT2ASq5PRV6+Rc1BcgqHtnAXit8SUTppO5qioZ2ndr9TT7pzIb+0HuTIm20w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW6PR12MB8758.namprd12.prod.outlook.com (2603:10b6:303:23d::18)
 by PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 12:07:01 +0000
Received: from MW6PR12MB8758.namprd12.prod.outlook.com
 ([fe80::621e:d58f:ba3:b52d]) by MW6PR12MB8758.namprd12.prod.outlook.com
 ([fe80::621e:d58f:ba3:b52d%3]) with mapi id 15.20.9320.013; Tue, 11 Nov 2025
 12:07:00 +0000
Date: Tue, 11 Nov 2025 13:07:28 +0100
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: Re: [PATCH v4 12/14] cxl: Simplify cxl_rd_ops allocation and handling
Message-ID: <aRMnAIwdMnTTK1Tp@rric.localdomain>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-13-rrichter@amd.com>
 <aQqF-xCnL2Ugh3hp@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQqF-xCnL2Ugh3hp@aschofie-mobl2.lan>
X-ClientProxiedBy: FR2P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::8) To MW6PR12MB8758.namprd12.prod.outlook.com
 (2603:10b6:303:23d::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR12MB8758:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e8074f4-845c-4ea5-2452-08de211ad1bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yGYfDfrvXmB1ZZioePIyugqf9GacR0kU6X5veZYLPlRxzA3CksMsYCjUp8Dw?=
 =?us-ascii?Q?XcXaMYk52ykbzgyBoOu4vD113lfVXupeLKiRe3zEvqvHSmB8Rug/E1bohi1e?=
 =?us-ascii?Q?/18SSAdLK/SmkewKng/qzU4vIzqupZJr8FeMjwbeDc6r2iQjOkahsbFWjd+Z?=
 =?us-ascii?Q?1mzl0Mn1gTFhs0UtOzVXqpJ6GBsbg/xrvyQMpimcmza0L1s44fdTJkz4uwYM?=
 =?us-ascii?Q?ozLYdzA7orz0skof+TlUdb/NO/YDHBEDwuH7PyG9dVaNgzsGpednsuVw617T?=
 =?us-ascii?Q?a1lSDNVo2Gxjy7QgXY2dUteZ85ScLKP+x+WmR4tVLDsPx7ONvFD/plpNa/7b?=
 =?us-ascii?Q?77EvN7hlH4gqWSd2isnT3hmVol7nvdJ1x1kUbJ4MhdUOomVoHy6Q8ngWhefy?=
 =?us-ascii?Q?VTj5UYLGE5djWqj4P/0fhgiLfOjsMiuW7D3zgC/+oWh3i99e+CRYpN7RyDyR?=
 =?us-ascii?Q?rbCyg57e5exeSrWgqYeDdbQy+PmQVQBoY/lqFupj56PbEuxy2eXJFAp2/H/i?=
 =?us-ascii?Q?2V1cm6839e1ufp8ti9wNZYtrzYrSA6w3s40xudhcBAqCUJehYsTHrGInm5tA?=
 =?us-ascii?Q?/Zl54bmTK4e+YhCVqyFoBXdEnfULSh5PiKULzF1NDhknn6zuJOXaJNt6uuoQ?=
 =?us-ascii?Q?mBHhROgyUR1Ci7EVba6L/MpthhPe5iGq5UV69kaIl1356CV6b3bgQeZXZJSw?=
 =?us-ascii?Q?R7GiaB54IdLR4Sm6w7kMIC76Embnaqqjr5bEo3HAfXkmc2Yy6jj7nyg2sBfp?=
 =?us-ascii?Q?M2QJ13vqthumwCBtxiNwHjuBYV3ne16sFIA9Dh1iERSmVpX8hMZbjp09ouSc?=
 =?us-ascii?Q?uvV8LnYxx1vY46JAwbMsxjfQrjlxbWxyO6BmtpGyZ0eRCnopBmjlmiPn83In?=
 =?us-ascii?Q?2U+6Ac0xCECnQ2PYGfO0H67pOjNSgX8lnam8zYAMwbor0YkBeWPVEtj8fIBi?=
 =?us-ascii?Q?l0GkGKuvorOyXaq7iI7w/3Eka2XJ/EDX/Y2mpVU/MIcHABRZCQvYpDCZ7+pe?=
 =?us-ascii?Q?nGcbsN2MHDNrWfc62Az5O6HYhVFh7J3k6Lm8PPDW4Kw5lMx+gf6Ww8TGTCqR?=
 =?us-ascii?Q?Hg8FjOcsTP1JyWqeHDJUcHWX0Pe332oHTeTH9LKmRjZCqiBVWCf65gm4dSt2?=
 =?us-ascii?Q?igNNzsbUlCr8/scHI+fuNL5leSvcbhHaRZwpSECc0AhdJker5lvkYIi955QY?=
 =?us-ascii?Q?2ctrTdGu5pFqHkNb0ZT5SEBgYY+PE2i6VE+dscmED3O+L+U6PEO7LZJXsrjs?=
 =?us-ascii?Q?Bkm1RJbtPWt8nmjyVZWf5rwtRTeT3qVnnVUWrQcNqj3H860e2zL5Uy7gR0HH?=
 =?us-ascii?Q?AisAGJEmAxtVR8mSkUbc6m3DVKlUvHA+XsXQrzzb/scSetLHitCHyMehgSGl?=
 =?us-ascii?Q?xaOaKwB7reyUkgPTtcC2V0LnCPASMUvnx47/OOd51C43pPToYJxnkJhX2rGw?=
 =?us-ascii?Q?wsyBUjaC4GsnFyvh9AhpqNgS0ozEl/DO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR12MB8758.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UgX9fpkY6Ou+T1O6h1JKQj0nWTMB4Kakj7/n6vVJd/79A+UjsvxNBWAPi6Cp?=
 =?us-ascii?Q?vdE3052GNazjedfQXwxuvhtbp4q+sJz01L4sWc6p6V9HU+7b7z0QyseV7Lqe?=
 =?us-ascii?Q?DMxbrSHtYyVL+MSCgqThTlMEyi72H15dgdHKR7tQSV/+h0SZfHAfT+uBk21l?=
 =?us-ascii?Q?jY1lYLsMNKwSrdW8wXTTXs+bvFDLRJhmQord2u8Znzh8+F0untylThTRJoSQ?=
 =?us-ascii?Q?kfxbpnPJAFiSJK9J/Lah4N5Qb7qZ8/5JhcOw7AMyb0tklCLeOQcKncd7aEci?=
 =?us-ascii?Q?kaK90/fP//HZMDWjgwcbDZmv6JgP7ZAMAE2FqIrbwWmoqzy4pGrulNaaVTxt?=
 =?us-ascii?Q?15NbtuBdQAaMLPFODonHMb8E2OAlz0iPA6ilCQMT38WamnQeKJh2Fe4XBBsI?=
 =?us-ascii?Q?DdgueAWxgjVsni+EHvcNigz+Jlox/MiJJaay58VD5smv8VdRZB4XgpJ/Nft+?=
 =?us-ascii?Q?Zgo9e5d54teDsSioBS7QZ+gaMojPykU6FrcnweXyz2iW58qPbhXBvNkmajs3?=
 =?us-ascii?Q?gHDIIUYi1y+2yIMYJ2HvGW3xxZb64X8h4qwCwnI0SoMdc2vdN2oWlh41gu0q?=
 =?us-ascii?Q?zIOXr4G9zSBa92ZwFTIW4hHm1c9oXyEhosDvCMyI9DBAFqI4GsOEQimlLoAY?=
 =?us-ascii?Q?RwoXo+0HezbMlK/KRpujlw6rjMG3HRnbofyj4Ch/x9Kxn/fiP/fylBDlpVwV?=
 =?us-ascii?Q?edLvvdpuFbSnuFuGXCG4mZ5TX3PUkZd1N/EWEdLvK8fhXBf67qHHJcTYlRjQ?=
 =?us-ascii?Q?tYLyyrUS9AJ5Y1LjUyqhs+QsY/GptCqL5s1s2u0Bfh1KQySQYgjaNLN1ClcY?=
 =?us-ascii?Q?g76iInx3Dac12HvvGI1RdBlUbbcflg9Q7YXiQiVN8uevFB1XRfQPMZ0r2cVu?=
 =?us-ascii?Q?Br5UHnpi/0LvqlrvTa7o6x0k4csGSJM4N91FEHCAdaub6x10fNSh2ar9IQKA?=
 =?us-ascii?Q?SEEGQA//SCxndxlPuc6a+H+WIxE3tcqGwlIF9LZpE0z4nNfeJZryxUaJU1nD?=
 =?us-ascii?Q?2zII3lQCqJ7gixIPJFiDUjZSryIlE1+x/xRz4tCj0Sy4+Fg0BBt6j0wntqJ1?=
 =?us-ascii?Q?CvCuTseIbs60G3102hFxtYm/ooBDSXslIA8ib/b6FXTYcgh3OolITXp0rsCm?=
 =?us-ascii?Q?nlevbOpigpCnPX//Wt3sKGeW7ixZCnVIj9m7MnJw6NH+AOFvfeAIMKCIn5oh?=
 =?us-ascii?Q?qK140deSRoimvI3d+OqV6QQZzpD9e715Yfc0fA03eDkUrySbyMEt9xi1YHGH?=
 =?us-ascii?Q?6cQszk038qtiAGymzSPK2MnNBWmGveGMxkfQUjBHRMKT6QCgzoHuSduSclw/?=
 =?us-ascii?Q?YTJUdnkVSiHpOm/VHXTLqBuduPVeIqYir4T7siSOqOlNIwReWGXvWg53Rv+C?=
 =?us-ascii?Q?A+2G++IknXJVFIDo2RzuI6beGwUib8CRWOcxhLrfAryNLhmuNPPKffRJNdpG?=
 =?us-ascii?Q?xrt32TDG67s9iXKLd9N85L+a9Qr5Dn1hdrOOmSVQxpDIyIOWP1Xz9E3GCUNc?=
 =?us-ascii?Q?naXYFIyVVoD8hcyvUB21GstAjJr+kJt3VXvN08YlF1SwbbDnIYmtTCl4K7nr?=
 =?us-ascii?Q?GNCJICHE//fMe3gLR25PiJjoXC4rojXSQKGyXGxw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e8074f4-845c-4ea5-2452-08de211ad1bf
X-MS-Exchange-CrossTenant-AuthSource: MW6PR12MB8758.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2025 12:07:00.8278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nd+magfA33xdIlxo3BvF2BEIC7V9Jzop/vg5ABGosE3wlDhYI2m/IADz6GX45n5WD2wIaNqIdhBCEJKvpCzRPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891

Alison,

On 04.11.25 15:02:19, Alison Schofield wrote:
> On Mon, Nov 03, 2025 at 07:47:53PM +0100, Robert Richter wrote:
> > A root decoder's callback handlers are collected in struct cxl_rd_ops.
> > The structure is dynamically allocated, though it contains only a few
> > pointers in it. This also requires to check two pointes to check for
> > the existance of a callback.
> > 
> > Simplify the allocation, release and handler check by embedding the
> > ops statical in struct cxl_root_decoder.
> > 
> > Implementation is equivalent to how struct cxl_root_ops handles the
> > callbacks.
> 
> The allocation was intentionally dynamic because the root decoder ops
> only existed for CFMWS's defined w XOR Arithmetic.
> 
> From the commit msg:
> >> To avoid maintaining a static ops instance populated with mostly NULL
> >> pointers, allocate the ops structure dynamically only when a platform
> >> requires overrides (e.g. XOR interleave decoding).
> >> The setup can be extended as additional callbacks are added.
> See: 524b2b76f365 ("cxl: Move hpa_to_spa callback to a new root decoder ops structure")
> 
> Has the usage changed?

No, code did not change. In another patch I had to change struct
cxl_root and the cxl_root_ops allocation there. The pattern here is
the same and the code would benefit from the same change to simplify
it.

Dynamic allocation does not save much here (only a single pointer
entry) but requires resource allocation and a 2-level pointer check
which must be run even if the pointers are NULL. If there is at least
one pointer set (which becomes more likely with an increased number of
ops) you need to allocate the whole struct anyway and dynamic alloc
does net help then. The diffstat also shows the simplification:

 3 files changed, 8 insertions(+), 22 deletions(-)

-Robert
