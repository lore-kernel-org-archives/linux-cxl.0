Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012026.outbound.protection.outlook.com [40.93.195.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A251AAE17;
	Tue,  3 Feb 2026 18:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770145197; cv=fail; b=CtceVkqU7p1DH8HWkTfUSEUg3sCc9+I93U9enNxKZhoPtmsdrt0K0kwCQfMB9oR3ir3K0sh0DGXLYbJjY/U9uQ6oykLcIThQmBthkkuutaygznU4kQywU+caqWGDmRp5XcwMDj4w4IvFz9KRKyJmTzQcfrimi4dkzt7jvOS+Acs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770145197; c=relaxed/simple;
	bh=UmpLKzr3TRK7owgafwbcSDUpw7d5HC39o/2JrnxVRuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=g7cvoMkeADe/7IolSsCgJy6j1DSjLsG/lcl2XPj/fgyWe3Gpi9rFNKnBx9eoMld9o50rLnY7WiSH1Imb7PgIQn1xk6DVVQ3Fr+etP+cbfPsB4gNZ7kkYtRJsL/f8dkdZsow+ZTgyGGV3OiddHYDrZcTlgZPyYuY91obuocgFt7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a63tSf9F; arc=fail smtp.client-ip=40.93.195.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a63tSf9F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUUr7ZRDRwauhTdFzFe06ndH3dlsHN+jCKzDkSv6b+r8b3BYAppC42IVxnYfBuBS7iZFtSU+k8EeeNevRr446MgCfki7LBEiFm9DkQMEfzZNtqJjI4DhlFJiwQo8EnfCrPeTovn+vGHHt1+g4ckkRB8vfoJ6YC+vUUluKearBMdB7mmdzAP4p74zb2X66yU8F18ve/QmP5kkEZId6SsgO5Y1pd1FkXe68PL2izmEkHW/ZfJcwOFm0PBNJjpLqZVoCEx5FhAjfztjkNzdo7QvZlvQAXhY+21zLLoqEcXZzQ/+6NrnMOu4uK9jVmlm42qh7xAcfjraT8nTJUtKsZd9LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQPm9RmvFZG0ZueTKXbLO9X9vFziZxXhR/JA+UkcxMs=;
 b=pkonhIPFCqWL10kakzBiYIlYzfug+OtZD4OjjdDsTnwoD4f6r2ih9hTzhn537QiLnKjIBs5E1MB4+I3jNNNJsFr720lcad3PSP3IoHKfBPfLt8NjUn63LONajtSqNM/mI7xJ48d9t5r2ntwIrrLF990nV6+SZ2Kqp61Epi16X3QHffqgD5fKf7Ap5UJjlxo8DP3HmtbyLszeDk0x/3TLFfxUWjy8N+atjDAuGTogaUvixUdpsOGou/YJeN5DRJuw9F+OX2KYUVihfL0j4UE3DwGgTAGYK2PuyCVHbVGFAtcAVjWfKu6UfzIAzdnGZp2gg2Iv4AJgdLQPb3ToccHs0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQPm9RmvFZG0ZueTKXbLO9X9vFziZxXhR/JA+UkcxMs=;
 b=a63tSf9Ft+Aq5aropc3qXheoGKdwIpFX49AufdE49DkESFTRdQ7TDppy/x7ee8HpKP54UKqQBVYzT1FPNUfYZOwJzoedzipad8m/6R53QOeG4bX24eav907Hm9ZssdesDNYgIQSBSK29AoPQ8aDE7Mae5oVmQXsfcIt+14PfslQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA3PR12MB9178.namprd12.prod.outlook.com (2603:10b6:806:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 18:59:48 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 18:59:48 +0000
Date: Tue, 3 Feb 2026 19:59:42 +0100
From: Robert Richter <rrichter@amd.com>
To: dan.j.williams@intel.com
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 3/3] Documentation/driver-api/cxl: ACPI PRM Address
 Translation Support and AMD Zen5 enablement
Message-ID: <aYJFniEo7MCrtSF-@rric.localdomain>
References: <20260203173604.1440334-1-rrichter@amd.com>
 <20260203173604.1440334-3-rrichter@amd.com>
 <69824378deae0_55fa10084@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69824378deae0_55fa10084@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: FR4P281CA0314.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::10) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA3PR12MB9178:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d67a870-86fd-47e0-cef0-08de6356671f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5LmFV6py0FsNxEoWYtVbV6X0rQJBO9wvztp1X4mnO8YfyuFZ5hvmd7cL/MoP?=
 =?us-ascii?Q?TRBDsnei7rj2ccp554gXYI9MvvmLpLXjlFBeR5zQhSmtb6YjC8y6032qBkuX?=
 =?us-ascii?Q?Yf3LSzxoqlqKOTQ4ucqpuEBD+pgqB+XOcVTAMkhy1oTv4VCe8+UZ1J9S8yA7?=
 =?us-ascii?Q?lc1FGKhurqnEOWfNQt5fM4Waq6D6rJXFnRUlfEJY0hnsCwYhu5Tu/XdoM42l?=
 =?us-ascii?Q?jaEmuNqbxIwBczOW5JyQX4e59FILMakvIwoFbO0vDU+ohStDkNU/azg6ZOYA?=
 =?us-ascii?Q?HNLp8cl+F3NqnoXBvlQD7yYaP1kFF35ZWIQgBGnJ5QKg4w+/txTYHHPZ1Caq?=
 =?us-ascii?Q?Hh1a3ngJrfnhniS66EuK3ZZLIb0XkuC4cBmDvGw9uIMCrySd/r5D+v96wGGJ?=
 =?us-ascii?Q?guIs5gDBSRgPP0QmFAUEH/v6fYk77J5ahjotIzgJAusHLj7u1HQfsvmUwwhK?=
 =?us-ascii?Q?A4xwIhh0iaB/vHxZOb6mzw70pbm+fhJ+nt6ovE9IJf7pH3rJ+B+nH1pzH29k?=
 =?us-ascii?Q?k/nP4fnEZFNHobpBp6xsBytNkYP8bZl1idk/hQ3sRTHRTeBSxc8Flnm8AXn3?=
 =?us-ascii?Q?94TY+DD6gYG1/cw+mHeBjtIlGQNmHm5T1vTO703LtI/y9wgIsjmzJbBdLaU4?=
 =?us-ascii?Q?AKjN9g6jsB2o3cAPnAzIeFJ71XlQyLWApJ2lGQldRqPZEVy4ziTXM1lKbnyg?=
 =?us-ascii?Q?/B53xG7v9ZAcj5Ag0zaPbMgxt+gOdJds4xUnn7gtdlTR9yrw3NnaxhHKzVAZ?=
 =?us-ascii?Q?u4NjNGw/N1GvLqKmvoroLTQnNLHJmHk0sP+N8S13bTadhTMbXSCO2Rsc/oVt?=
 =?us-ascii?Q?YvISA8RYXh9T3QHkZjidq6CE5MEdjIi44xKpeCdbnSsq3+jnMm4a9TRLbx3x?=
 =?us-ascii?Q?5SzDxaW7Y8yPtOI0FnRFn1UxTS4BrDxf/LZQ6MUmR8lIh0hdiueBBSitP5OV?=
 =?us-ascii?Q?B0wAw84uUeY9jEEU2Zhc1JNQ4+Q8T6x7Yb7WxXysO2r3lmiLCgjMrPLbTnwu?=
 =?us-ascii?Q?xOy71RGHqE9b26Hcp18IL09oUaCR3Vr7mnq6s+EPX5dWAqRevzacbOGxtFov?=
 =?us-ascii?Q?FsYq5lmeiRuo56vOvzNy4sjsHt8rDU6OhcvkRqGOrEPmQjUpczXd3uLtr/LM?=
 =?us-ascii?Q?X5xYqEFM43sxjqBbNQK/XhTveWbWFxVyiMA006n1XYcaf6f2FzAe55YcFfsV?=
 =?us-ascii?Q?cERngzE9nsioSlf1Zz03u753jeRAOSAjDbEYNHbN2gen02fJh/A3CLhp9+aV?=
 =?us-ascii?Q?4QGTrSaCBMjcVA0OjpOKQQiPorv6uru2cKMW5+juFJA1FA8zTeVoGfW2MpZu?=
 =?us-ascii?Q?F+4u4hcMiJSv4d0wI1kWB8pNEzHEjQyOrvGsZJRoSXKHHEuP3g0mQGZ4XNEZ?=
 =?us-ascii?Q?nmv0n8s+Vb3Fr6qiUrxh8fhv2vtq/mrkwerBeVRTkbEIDczNNNJzG7ORGxKb?=
 =?us-ascii?Q?HPOhrpUpuruBhcJYtWQUmVklm8L6E2luLCi7ZCYmex/3VLdZ3EVtsZ9R3hec?=
 =?us-ascii?Q?1lFnUltyYz3cR7xwgWlJzC6K5L0gbWyfd/DIwwettso0JSktCDiWO7v+1juz?=
 =?us-ascii?Q?v6k9zAbgplAbUr6La4/9cSYqB4T6OIgR5t8cQiZj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jfehQrBAwwtgl+b9ajUYWcwXrkiIAerepxgx+mWC22K8oO+4676gsUD0JlEb?=
 =?us-ascii?Q?2BENYaVtnrPAJY0mWbBsoT3Y6+kD6gsqy6xxhHjIo0VqAfVCzLSQsbjNuDV7?=
 =?us-ascii?Q?E7upKNPKp9VHQjMublJePW6nCFpF0Pl5kGA6g3Pnd7F6XN3UhtgbbC4nUqBt?=
 =?us-ascii?Q?VwDM1PLJizXoVVX9N9P5iUQaaDoCuc6Zzvs7ifJjXvCszWeki9RIVzFLW3yI?=
 =?us-ascii?Q?FkCYqdOBCmdCgnd9rmTEZvhhbP4envIW0CEQxDqFNOyJQMOSshD7G0+8NcGY?=
 =?us-ascii?Q?w/qBBCw/OCSEvzgcMUZrP+byV13ofXuCpnHkSY+f3sWdFl5Akur+WRskDfy9?=
 =?us-ascii?Q?c5CN/fguPFubQghowyxepsH9VR/n6HFnYDEGqdJ59O0YTFAbiN0w/QD9dao8?=
 =?us-ascii?Q?RjB4IMfdCTpaK1ct+J4LeXMCk/uWlx6kukUIj03xKH7ijD4vv+IfRDIrv61l?=
 =?us-ascii?Q?5+HTytz038WOZXprvex96zhszyv0QaAnwS/0tePXeKUSpLwa0FEgkocivHsT?=
 =?us-ascii?Q?gtyH0jGOOzcUB7N0eV9y3wY7vLWj19FtaNEWQhVpUCyMm9/C8DnP6NSR9Pom?=
 =?us-ascii?Q?sK79OOnL4T2Xo1vQlIIXgM06gXfLy5eL2fgBGHwb7aCxK9nP6nEblIL9LxP7?=
 =?us-ascii?Q?iEXWeK6j4vV1vJpg8uEtKbww0Pw6tjrmED8ro3EnCa09n7x4J30KsgOU79Sj?=
 =?us-ascii?Q?dRbQ17Y6FppJr3qe8r6PDEewrbtkXS8xv3qHpSUHQKRvp9C03R+Rw+mgs/HW?=
 =?us-ascii?Q?Let8T2zOVslWaTmcGOn/MOhOGe5a+Jc5MU15BDn0tnP7m1sxhpMXv0EpXpZh?=
 =?us-ascii?Q?P6tDvOkZ/LEiT+FM4yE81ndlLnNgpiRdZUFRq1ijZV0OKqLYYeWk2pbA2dmK?=
 =?us-ascii?Q?WP2A1Ob6MHdDJtlGkFePs5cqP09E1ayISUI3EUfGbvh2bymwvkeyzLJ4KRWg?=
 =?us-ascii?Q?lr9TFLvGR247kgcVfwGPShPpZygMo0rvZ1oh6WB3T5DqZJ4A3UvdNRmdGyiu?=
 =?us-ascii?Q?wh4Kz8PfbZQOMO7luInPVY0LlAzc3gGBqfw6AQnVJAtVkn7GxhMUWBW0gRF2?=
 =?us-ascii?Q?WV6pJcFALx322F6fP+UMutFDQTe4UfaJZ0gEz//2SRAIMGbgUXZRWYMSjLCb?=
 =?us-ascii?Q?epMzk7S+jebzWqlYx7JoM2g2mztBVXjKa5UBl09c9lVAtasrGKVVXwaHRKHx?=
 =?us-ascii?Q?YOoO6KcZgyBbFYqECkjex0mObyR9F0mS4QSY0OZ6AibLRwN53QQdzzEU/pHk?=
 =?us-ascii?Q?b+5/ISV47jKZEM8jivqX/k/X2KSHIpgDWD+3ncp+cIKR9J0oUOFrZrao+DBK?=
 =?us-ascii?Q?D8gMiEg7AqWc7T823yfKXxJR6MQ1UWPOhqiODNcVpJyfGkZkJQEVKMKkiBPH?=
 =?us-ascii?Q?L9lRDgGq30LW7kwH97UuGtwXzA9kaozEF3wda76W++xLBgyjyqZ1KXDuNxUK?=
 =?us-ascii?Q?6MYDmNWYfKt9eL9VBBvn0qz4TlNacgc/HZYVVgr6WjXMgER/p7eKAxeQR6rz?=
 =?us-ascii?Q?5MrJ4fyRbH007b7amN6qqJkU0sogzcpEceAb370AUqQ7lDallRYC8mnmt8d8?=
 =?us-ascii?Q?EmdRCRhBOZ2iJd9GMMzsuDEJcqEWJrl1xH/3dtsyW4rkKHrVJ0GovD3mgVkG?=
 =?us-ascii?Q?eVKi6eJzM9AirU2CdIUy5UOBViHURUwD7It1lLEXRKMtjg6HBTDyjOoQnGU5?=
 =?us-ascii?Q?ltNpzY5pe8Uj/UFpk2TLDWQyfbT2TQzQRfbPGtAH12eZJBr0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d67a870-86fd-47e0-cef0-08de6356671f
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 18:59:48.3793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eWTbgW2tYAY4tAqa4rV07PCxO+Emni3+0JnakU20NfyhNJSjQ5wqeY8qyvWY4QDPvoEmL4+lzSnRTsoeMKtMRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9178

On 03.02.26 10:50:32, dan.j.williams@intel.com wrote:
> Robert Richter wrote:
> > This adds a convention document for the following patch series:
> > 
> >  cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
> > 
> > Version 7 and later:
> > 
> >  https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
> > 
> > Link: https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
> > Reviewed-by: Gregory Price <gourry@gourry.net>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> > Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com>
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> 
> Can drop this ack, now that the Reviewed-by is there.
> 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> > v5:
> [..]
> >  * made PRM handler mandatory including the GUID handler id to be used,
> 
> Looks good. Going forward let us not reach for PRM ever again if it can
> be avoided with native driver enabling with some static platform data
> tables.

Great, many thanks to all for review, testing, etc.

-Robert
