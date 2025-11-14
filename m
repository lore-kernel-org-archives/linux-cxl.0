Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE9226FDAC;
	Fri, 14 Nov 2025 18:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763144724; cv=fail; b=aOpYM0VknzJGY3AO/cAkwiUM7NFJK3k0lDDqsd/UaOf/787mXkYRilZeCVjHj50R07y/TgaWW5lztsInrDGzLDiK05qq+oQ/S4w8W7EBNiSeipXPTQ2P4DCZCdyTNHjpz6tWuQj9WfA5WiGy7/+vY0ua3EmbzT28J4XsJMGfMH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763144724; c=relaxed/simple;
	bh=YqCnT1hhmIkotPfYZM5xwyjVpLFSZ3nCnqbVgd7qdpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Na2yXKUvxSkY4JQ3JhJG8uQNDvMWoViOYiAFsYoEVdoofs0TGdl/vVKpMBCMW9EoOqvWdS+Vv85Pw/PoFWGppy4I31iuOEzA/ry7rph9Y0McMgLRmhKcaaYeQPyewYooL0bdju8iYBU55POAt93iCFXbRZHULZpVetzaNSa43kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sQCc2+3v; arc=fail smtp.client-ip=40.107.209.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sQCc2+3v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lb7N6cMMOetIveBUs8UbaRiPOz56sbGWf5GHcp+KydgZypJlebBp0ZjuCP31vRqrDNYGhrk3Wmgc4ZtnXi4Gnggvq3fH7juIU2uJDJlJeND5ZKpTBQAXd/7PNDXVYaSSn6YSb4qwRZVX5C512hOYKvUeF2aFDYqkV04uSu5q5mHZ6De3bCjN73AR3UsPYtg3ONbySxdz2A/PPiXKL2z/xyB4PN6f6jY6MsfglBIEMjAJ3K9fRwgmj2Dlp1xed3zWIsuKnIwzBqa22v6y6G+XvsLpFqwUZzbRHfkRKw+az3XHZTMZgl1ME/EMkSBX4OVE7Qyd3tkyYsGvrCwAOdX/CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GQQhV6+vy7z7z9CF5ugIKux6/JDUaaGfUuT9MXlp/yA=;
 b=QO2+KSKrnwlv47uCTKCTKph/pCs2ijWC35EcexXNnneZq0QpDnsm9cmpef4XGGOHupCQkXP+twnpQ3w1os0ihi4Yuv2Qo8JPOwHfTE0vBqj8N7+A/7dSRpKI7XQSsb1jNsldMXnayV/sDCig4buJxTXw5XIOa/bGNlJtQB/53w5/uPptMjp2RcK7rpQMDH7FrW6d2lH0oYGagLhpL7r5OI0vxcF8bhMTqt8LvCwSoF69OYCV7PEqbqRwh6eY7Hyzwx0oB+w20MeQCdL+xjtEcecKHevw7BGRyzknKZyIp/sz/NwtGwCzP4PBEC/i6/FjrCNNNbTMwrZW8WTI3yAjAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GQQhV6+vy7z7z9CF5ugIKux6/JDUaaGfUuT9MXlp/yA=;
 b=sQCc2+3vOSORQ2iNd2ymZ5aBBDR8n4AureklF8dd97pHCp88GdwIMBWEZUkFNh1+gcgYhWN8ouXwZKdpkHLJShxqgjhSdPtdDaFhj+HT8tW01C+BoAYY1ETSLX20yHRPnz6tWjoZf/rqy+7EQYWysJfx4WXSalNN+Lk7IHevuV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 18:25:20 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 18:25:20 +0000
Date: Fri, 14 Nov 2025 19:25:47 +0100
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
Message-ID: <aRd0K1MGNGUduYBC@rric.localdomain>
References: <aRW6h127k5Tzns8R@rric.localdomain>
 <f0285498-810f-44aa-8577-e28641e97d56@intel.com>
 <aRYLJmjBsggjzA99@rric.localdomain>
 <a0881237-60e8-4bd9-b990-b72ad29c57aa@intel.com>
 <aRZBOmQH_pVs93T4@rric.localdomain>
 <aRbx1EbsGqUDY3Rd@rric.localdomain>
 <0e473cd6-12ab-425a-a5d9-b94226bed8ae@intel.com>
 <aRdXAVPp2jHwfJ8q@rric.localdomain>
 <81bb1561-5d97-45d4-b18c-0568d359d763@intel.com>
 <a1bcdffb-c03b-4d87-831f-9c58415af5db@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1bcdffb-c03b-4d87-831f-9c58415af5db@intel.com>
X-ClientProxiedBy: FR4P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::17) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: c1aa1f4c-97e9-46f4-b8e2-08de23ab2acb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q7958uXEEQMNgk28aUoVXU7qjxo8rEzSpcYSGOYe3XNlFoijP9UYwwq+WlHh?=
 =?us-ascii?Q?HBERSINFIN5aRU6hw/2rM/Jpv9cZWBKFDWx6S7Nc0uaYGxBA+/DsAY1Y4n6d?=
 =?us-ascii?Q?lqil/YjQE69mi9qIQhFaB/hMJKdvD7MOhDMUFeVw8iglu5xn3myQ/0lPaxKf?=
 =?us-ascii?Q?sJXz+umGfUG/kO4wFc7slbuLuf9AUcJJigGSIvas9Dc3Dl0ihprAfJuujJJY?=
 =?us-ascii?Q?vPlRS8xuTq8ZynU4BTZYLEISM4SfT5uAq4BPniqaVTDCot0PLWa0XANAZY1F?=
 =?us-ascii?Q?GrEJWdCBR/locl/fXVfHxjFx+b/oVmnyQPfTmc1QR2HTmi2U6KDctREypIho?=
 =?us-ascii?Q?n3To6n8W5DLii43OH48xRL2rl1ERm1Qt5wExrBF7u8KH+SteRO7Mryxa7+K7?=
 =?us-ascii?Q?aTimrYC2RtNPHQuq4DqSo8uhWmZlTVNldRXtZFHxgnXhyaz4MP4teBxqhhdA?=
 =?us-ascii?Q?rN3wq0rFKgNkjofGkF7Moaz8Kpq9RvedvSDXJsicQ+wpYienXARy240VK9kk?=
 =?us-ascii?Q?bVYlDecF9Z2vSLuy+5uh8iIH4JW7anX/8TSbPX469jrMfe8XftmOeTQbSUom?=
 =?us-ascii?Q?LJJfNKTxkgTcd4IXqDek5DZd/QGF/AGIC0VFir5ZmvtM0Obgxayol9U0Vn76?=
 =?us-ascii?Q?FEVdbdMWQ+ZlD8Sd9hlcw7ZsQ+eEl5A8Z3Vt9F5Z/hV0QVfi9WSfkrH5q7lZ?=
 =?us-ascii?Q?DujZ8/YiRuXZtdaE2F5RfcI8wCnR4k3aGdT2i/VVWseHRmsekcbW5HnvPlij?=
 =?us-ascii?Q?mtayYv12FSVjWbcWCk1TTq1zI9HR1rqUf9Cu2SU/ZTu8RcVo0qKijwiDU9VQ?=
 =?us-ascii?Q?ktlA6QuEX7hifBpZ10nYqjJnTttquQa59S3J7xzd+LV/OpppKCYN12E3mKpF?=
 =?us-ascii?Q?mIzRUI2TdRwUAqnyStxCBymPsEW3ZFwsxUT5lgtWVlQiBehj1ItzjAwqlg3d?=
 =?us-ascii?Q?y2qf5JTwoXlT/NsKuOla4XkX4mKU4BMXwUyR4rrlC3ptrQP1FIkX8E3M7ld1?=
 =?us-ascii?Q?69k/QkjfixaQoxF3pE4KR5kl+tz3Ezf+b0Hl15ivjczrliAl1fzFrsk6V6Qi?=
 =?us-ascii?Q?DGIyN9sT88ahnoLxdOtpZdjaHxuUdYYawtMQ+qLu8DqBwItX9CxTrjbx7IBT?=
 =?us-ascii?Q?/SofuoRCO9n280R3pVPlsGUiPW/ElzCWYWWYLzdI8zYwxCwJsHkqGY1PmToX?=
 =?us-ascii?Q?/sQgQeqE8ti0K3GtlPPVk/g0qqsEFHX4q7200O+PvyTC5gaMid95wU7uJnm6?=
 =?us-ascii?Q?6NlbPd3du1tar3wNXNEvr7N2xBWJOAXRSUOgDUBoOg8C4Bh1j1z29Q/BtQs5?=
 =?us-ascii?Q?LcRx81G7307/W8fBISaOdhs/PhoOrEhR/qTctKPBOmSn6WlZZP2t+DVlhozv?=
 =?us-ascii?Q?UphKGNmrcB/9boi6Zn3V1B+8+t/euMt9hmniAh9xM8MtxCZNX21SRDO54FOB?=
 =?us-ascii?Q?vt+7ZtczdtL74YPNlv7eDNgPVd0vcO3G5yPNEuHptVRMhLMJP+PqqA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hO2mgrgWpM8125WAHivoTzxxWSHRHKDsIXjIvGQgQe2tQndWTBbdMynHzOtB?=
 =?us-ascii?Q?QEUlIG4jyglJUBlyBDCdbGbiQiMsO0Vcr2NVhRYyR+VNt2LJ/fmx9bu3oA6j?=
 =?us-ascii?Q?dmCdfQPzG/sGfnrodxqS0JHxWg/J/Ax51MXdjNqvFTE0k52l+KVksPz24jL8?=
 =?us-ascii?Q?SE1EAL2Fpm5L/blR9gs7lzs8lI0pgoO/OZOE5bQxRxVkraHDLS5IEX2CQ0OC?=
 =?us-ascii?Q?HOhmPctM5g0MXtlEwKUQuRTUMskn89hWNs/CzrCz2t+QQkc+Qj2BiZ6eq5iX?=
 =?us-ascii?Q?Xwbjn5ozJi0b8YPTexzVLQBj4pEH9qDoHAPbKNcNTIz9RseAo/h21gY5R/v5?=
 =?us-ascii?Q?KtISC5S0n+e2K9UWIKq3bzecYT4KyVuowpxexFdy/66jmugyl5phunCj0INO?=
 =?us-ascii?Q?21JXGDx0KJo4W0WpBbOrV0lURIoWc2uJ2iQGa06O01gxIUSGsXsM1yWcr7OZ?=
 =?us-ascii?Q?tu9bw4Ew9aFk3ak25FrFuVO3ALM7Yjvbf31F1IHpIfU3S/9Wf8twd002KpSt?=
 =?us-ascii?Q?48OPcraj3vBjBRJkyj8Issmjj2WRS1p1Wi7vNOVx/4jsS/LNiZiB2TxZem1c?=
 =?us-ascii?Q?6wD2HzR3RrcQWtndBdK60h/JijeDLy58ur864jPyDBes1CRtNEh7YnaQsCtL?=
 =?us-ascii?Q?8GqR5mC6fdeZyuyb2dRWE8U8UUw4O1DQiykKOEzT9kAiYb3ifreH9hsfd1HO?=
 =?us-ascii?Q?fkdHYF8GRJ69v5u9TwcPZm8cbH+g+fsqLP1fmTQHeSkn6gDA1BFFhmmAkAii?=
 =?us-ascii?Q?9apLoHJdKnrAw81cMyczBSzlEtLlXoM1tdKhI5pCVN/EsW/QfCVvcMnww9HZ?=
 =?us-ascii?Q?WVN5UAlM7+y5T+kQMgH7FKZ+8eFg9wi9whhTXKuj6KOZym4SoBqqRrRhqQr2?=
 =?us-ascii?Q?HLZNvMR/kSGuEhV2+C1KjvBm68CVoOXG1bElaWlHCFrKjINkY9phj74zw+iS?=
 =?us-ascii?Q?lETSUL5D1Ob0XnRZPNQjbywkhYRQ/LXToBofmreJo0Y77aQ9AbkR6CBJRyAh?=
 =?us-ascii?Q?Vjl7BBE/EKstnY8UxQmMh9yXhzf/byToCiSI7n/DL/Jz8tnN6BijJ/IbEaXG?=
 =?us-ascii?Q?uW220x0pSnsNFpKnLJhyYChY5Dkx+wp3GSpXoWM3RwoV1cGPbD+lJLK2a5M6?=
 =?us-ascii?Q?Pv4KQoDtcK8HhPXYmiK+WJqfxXaOBQvJs1D/pTy/M6rtVQMtUIrD+Ji3C+8K?=
 =?us-ascii?Q?Gd0tXQH2wygA2cayj2jD0iIXKaKsLDoBCnkH3aLjlTsCY+/2MjM1z+f7XP9q?=
 =?us-ascii?Q?19VdXKZCMklaTZ4AbCj92j3DClUvFoOZAi7aR4IS/QmaBexx55FrllevS9ut?=
 =?us-ascii?Q?EzJvT1/X+zsw7OaMjkI6cQWJotvYmfYLs2JwbQggSLAhS7XxUIel2eaQWLuG?=
 =?us-ascii?Q?OyvWxMR+0YZxKTb5w/Sjpb7rlQa8CdPGHbEAJyHMa8YP8Fn8q9KMS7lRrTg+?=
 =?us-ascii?Q?4hFbz08frkIkcNRLdTHN98Y/71Tk5JU0DFib6PeEwa78ERh7EJDmfjze50PJ?=
 =?us-ascii?Q?CIqiJ1D/63ea7RTqqkMnqrcJYzOd5qABhTijTvh4kdAhzb72vVabnnQTcGoe?=
 =?us-ascii?Q?jczC0AJhw1qVdF1TBgSro05CVe2OEZ0CmcZuQ+y6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1aa1f4c-97e9-46f4-b8e2-08de23ab2acb
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 18:25:19.9179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wEn4Vou8gO/yfkndQVhU/QJy+TNCyUDJcukPfYD9gPYZi4acPrzpyiXEqcmPfzBY6XK0ZLtKRjgS4gFPcYj2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200

On 14.11.25 11:18:23, Dave Jiang wrote:
> 
> 
> On 11/14/25 9:28 AM, Dave Jiang wrote:
> > 
> > 
> > On 11/14/25 9:21 AM, Robert Richter wrote:
> >> On 14.11.25 08:32:00, Dave Jiang wrote:
> >>>
> >>>
> >>> On 11/14/25 2:09 AM, Robert Richter wrote:
> >>>> On 13.11.25 21:36:16, Robert Richter wrote:
> >>>>> On 13.11.25 13:10:56, Dave Jiang wrote:
> >>>>>> On 11/13/25 9:45 AM, Robert Richter wrote:
> >>>>
> >>>>>> So currently we want to apply the 3 patches ahead of time right? Can
> >>>>>> you 1. post the series against 6.18-rc5, 2. provide a public branch
> >>>>>> (github or kernel.org) that merged this branch with cxl/next (given
> >>>>>> there are expected complications) that I can reference? That's
> >>>>>> really my preference.
> >>>>>
> >>>>> Ok, thanks.
> >>>>
> >>>> I sent you a delta patch as I don't have a public git tree at hand
> >>>> right now.
> >>
> >>> That works. Have you sent it yet? I don't think I've received it. Or
> >>> I can give you push permission to my github repo if you can give me
> >>> your github user name.
> >>
> >> See here:
> >>
> >>  https://patchwork.kernel.org/project/cxl/patch/20251114090532.1323361-1-rrichter@amd.com/
> >>
> >> -Robert
> > 
> > Oh this is merge patch for the entire series. I thought it's just the 3 patches since we are merging those ahead of time while waiting for the rest of the series to be ready?
> > 
> > 
> Robert,
> Can you please verify that this merge looks correct to you? Thanks!
> https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=next-6.19-merge-prm-prep
> 

Yes, same what I have. Thanks.

I am going to send v7 with an update of the comment of patch 11/11
(decoder lock).

-Robert
