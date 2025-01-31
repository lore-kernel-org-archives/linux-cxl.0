Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E51C3BE9;
	Fri, 31 Jan 2025 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738333686; cv=fail; b=pjV72t/qA5BvP2kfsPE7XxARrGFqeaHEvVApXz57xffXugSSNtLdMe/MGPZ/kHkjDxKTRKvdATDP8PpOAKAy1EXUdGSEoN4diV5hxtooKgysjqqFXyqgjqWNYvD0GhA6mBK0rkVl5b3y2a+/wtwEMERZLEbP4HxBoCMMANvKWY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738333686; c=relaxed/simple;
	bh=Jqk6s+mvtEAPA4IgghJ6y5C+gAbgeDRtxw7jnQIVo14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RK1udp1f5zmcq9Ly1qCq/5Urj5wnpT1qDiZPHPW31sPaOHkEHgO5d8w5TFqDF3GZdZBOZlK4qH4/eTdLYMpGFLf04lNYHCK3rBjEusM059IvUqr0CVYfhoMI1Tw2H/cHV/2ySzZD4Ul00Ohgdqb2hK1wG4fiDMCWfgkXkELQHG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D5Z5iDL0; arc=fail smtp.client-ip=40.107.212.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D5Z5iDL0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmBT9Jjc137qTRs7d294aiztViSDLXeKiB9aB4cN1YYAh8vXmY5uyHSxt4ekl7ikezbCqp5MmBTrAZoisO7TXnOzH6iVyshMOyCdr3wnfG8eq1TNYIQ7vsSJ+Yd+xWc1KSAvfu7288otNJ5keqt4gAx7NfAZf5eB3K7CXMGJCMhSdMA316NLhUmT7lNjprFKAadkq1AU/nKLCNeDLgExjTW9lqyEqXZ4Qt+hcUHgHmGbG1ix12OgQTfMcDFn0A0442Cuc7eJbI8y1oHj7tzZZX3XouZIk0NaKEiAz6yULoh8OuzmTZOdu0GzrPEqVMw5I880vcjBA+lU+vONXE0jfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QE98968/2ec4wmuisxDaeUWClr0puYsazZRRRwFjjTg=;
 b=gLn+6juhiR4v1tRMgQh1ZTiL9+wJepTcm7mZtY3ed7CH4QH+vXkX8nj2ZFzyo2lT6hUof+JtaR71RZJSn9qtBe5HIr+vKYOs/E2Cy4g4KaboMyhEEi4Pv4uyIW2RIwApl6MxGTjwJW0gUsyNkExm+dFEykTQdLIMX17l7OCLF8anju/4ybeezPgbvvwGyQROk0RkQgHBas+VCbYwyav8P4wIAtF/8H9gvZiXexq/YwL1O2dO4ySafSEP2d9vA3japn2tATW6IEGykSQOxeba4Zdh27QB4m9XVKfc7NB71xESUFrhCmK3v19ZnDHw0qTzy79best3lucDqYgzuhTTYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE98968/2ec4wmuisxDaeUWClr0puYsazZRRRwFjjTg=;
 b=D5Z5iDL03xR1fL/eMkjcnLaFBS+WlroWMPbkwUOJCOhaRx3cohT8j2SemQUQQuwPiYrMMSVfNqnTRw7kJX0DaFCHEwlrA8rjvPOmJQC1l4JtGm4xfuGon06H9OzhYr5t1DDNvdD9s2jRayoraTbJ88ee9HSyfI1xXxgy+eG3784=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by LV8PR12MB9451.namprd12.prod.outlook.com (2603:10b6:408:206::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Fri, 31 Jan
 2025 14:28:02 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%5]) with mapi id 15.20.8398.017; Fri, 31 Jan 2025
 14:28:02 +0000
Date: Fri, 31 Jan 2025 15:27:55 +0100
From: Robert Richter <rrichter@amd.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v1 12/29] cxl: Modify address translation callback for
 generic use
Message-ID: <Z5zd60Vaiy7Q1zv9@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-13-rrichter@amd.com>
 <6efb6772-dbab-4412-8efb-95a698ec1ce5@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6efb6772-dbab-4412-8efb-95a698ec1ce5@amd.com>
X-ClientProxiedBy: FR3P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::10) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|LV8PR12MB9451:EE_
X-MS-Office365-Filtering-Correlation-Id: c6429464-80ee-4819-ed5c-08dd420377fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IJ5ubZbj23QsC4ZUUg8UGtpomMXzFNxpJuNHd93onFelpNj3W6dn6+G+etA0?=
 =?us-ascii?Q?bkpR5pLdhdQF6OBNx+WF8HWTLj09IoeHtX+a2Cl8koP40JGOUMVwhrNngtsM?=
 =?us-ascii?Q?w5Sa0N0RutMXSRQNZA2emllMQJE5G8qoqqaAO3NYltohH14JPkXKwn/fKvGm?=
 =?us-ascii?Q?DkP4fyMDZPhwaWKpdwjE/8G4j2VMLQZUtl43g+tmor1N0hAKf9ZQBdBMd95d?=
 =?us-ascii?Q?cW/PC1blXTzkkyRLLzUCRttkIn7IyE3n2QiMjMcCiAXPrW1DazrmnP54aCNR?=
 =?us-ascii?Q?J8GMEVOkaJdqwX2htZhEsyhfnhjfGn1U4HE6F0XBNwrwFsqcNxYv3SCS6iUU?=
 =?us-ascii?Q?VccTMsi/dSNN9mF7/wUUDtPxinC0ruPouQ2GqQQp7+vs4h1U/MCkwc7PxKkI?=
 =?us-ascii?Q?U4BVedwV13BHU2mOZ+prVIsLT2F9DkAeMpmdnnynmjC4QVDZd8FMrhJ4Xtzv?=
 =?us-ascii?Q?raIKMbB2a8PphLJBo3KeEsEmK48pSc2hQT8cgdscrL1avsPAeBwPO0ouJ4nL?=
 =?us-ascii?Q?VQEOX/w8iEfC51yPpyP3SY72hIaxkMcaXEb8N2wEEJCMlPsksj80V8Ij67xU?=
 =?us-ascii?Q?acNjB8CMsSHA/HnsLp6Pw28wUTMAq7Rt5zeQHArVZUOVNG7BUfRsB+EkViQ7?=
 =?us-ascii?Q?drmCg4HdltINvP1zO/1t9pYSc5Q67RX8mWfrp+98cUuefGV+Km8in9JtUFNV?=
 =?us-ascii?Q?2tA1yFdickueu0hMKu3THpOgtB10HyCbKdKvzNCDRUrIMcW/S+BI/mc4FyQa?=
 =?us-ascii?Q?A59OqoDxRHXO8tk6a0iTU15y80z+PziLZY7b147hGcQlj1DxSUK2YH0mqKME?=
 =?us-ascii?Q?9vvJYQ5K4FMCdwNLoZfQfDf1G4fM1zY/MBjTtPcVq4qkw4/bqZcdFdRpeZve?=
 =?us-ascii?Q?KyOzjhMWolmJpxFuNR45jTUYnoOQSh7ueDf5cu2sLkj1QPPyhz2fYqH+ro/x?=
 =?us-ascii?Q?dg608+i9oUVgVOctoreufXv+jrmlFZsuNhVlh4l1dTXrmbFf/ObAYosy2ria?=
 =?us-ascii?Q?OKgCTQjRG4pjM1r8enx4lgTv+e7qoK6kMj/xjZFS5GSMwQAS1g7NN3JPFpTx?=
 =?us-ascii?Q?UyvEisqlTduV4+gztHxdTnUJYk2zGy/13yZ9tt2Dr7LFaq/3peNSBs0j+9Lo?=
 =?us-ascii?Q?FHzWSDpLifKZNxwgbMTXdI3svYUNZvsN0TjoMnfXRRO2fE8Ix/ng+zA6g3mu?=
 =?us-ascii?Q?pE7++6g8yMYSjy9OkBsuGkKQWMAmTj1CDi3v54BCIzXGu1X0ibXCVwFgHdJE?=
 =?us-ascii?Q?D5LVHJEEiQFXYnxvE0MQEkO2Dha8U5AQrFi83fW/LLE9inZ9+rHaopfdzFZx?=
 =?us-ascii?Q?MTKvHjNeGcvX8HutYb8JeRcRiorPYCYD8chOyOLY9APYjwbZ0vyh4ygaM3vS?=
 =?us-ascii?Q?xwKT/xToWOlo10KGWbRTrahADEDy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?X0Hmxvsm6uRY/tBBJ3+3k9F7hP2Fe8hzaSpKJ7WaFQP1jgjugnkfr7VeqAwU?=
 =?us-ascii?Q?sA4Y7nCmSOLI8eSm33UJARah8m/0u2xdnQQfdRFk0tQV84E4hrH1zyg16IsI?=
 =?us-ascii?Q?/6LANakZFNgjsTdkkP3NZ6pbUQ6XCyc7sMg7u7AGIFuQjHGsIw918XZipLBP?=
 =?us-ascii?Q?bvMrl8AguAfdGNCHIcgvzJoM1TI+pgRbOHa21iwqbxSudnXlNPA2nGhWKa8f?=
 =?us-ascii?Q?Fy6aLhAEAhW6naVpYSqj2YYQW3Y5XAcRme+937bGeYbMsnUQHtjA1sX25vAD?=
 =?us-ascii?Q?xzd9H3Z4yl0p3LexOauD3qL43tt2bB3yByPIqQkZzHVw1NKsQ0yaRpeHaFh+?=
 =?us-ascii?Q?HeYE0fYcj7eMEe5a7d7aJQa+S8R40VatLgDPMU4gcep6eU6nhH4FrlVASq9P?=
 =?us-ascii?Q?wyh200iKFM/w3ltrYkSmrCabtI0ZcgJ+ghFMl+T/CKfDooHO4aBGjOedRrF2?=
 =?us-ascii?Q?3VMfOFB1CDLsPSXeVfpFnyFP8z3QO20aaWiC3hKwxw/3QjUYUpIMW0fEZH7k?=
 =?us-ascii?Q?rQNE5m46VcoI003WOfv8ZZ7lWtEGrhS6503jmqB882LyfKxx9rxElk3l7zvo?=
 =?us-ascii?Q?swQv4fXqhuCSzYxAyw1vBlaTeYzDo+RkOWEqPVMMqMhaEsiQMDQQ35xxTGvz?=
 =?us-ascii?Q?VSh2duOlpnTQ0VX1UYSu/QHOeQeTKs3MC5zMRoybUcSQhn90pMltqO5eI3WP?=
 =?us-ascii?Q?sNnq8xenF1B1M0OLuPAtiyTGRxu6p+yhwxGbj4E+9bkJecvpV9DWmI8iQUn0?=
 =?us-ascii?Q?o4aVr7u2VHOqCpwNQPPai3YhMtKSYQJbyDueFAUzHNYYmKjE/RPHyInFSLwf?=
 =?us-ascii?Q?RHL4QOfNrGhZTC5WbZqrcScmYazv+ENMfNgCdLhTbrrJBQnbEo0Aliznsvp1?=
 =?us-ascii?Q?MqdNt12MZinDPWYIItpBb+Vnm8DuS/nVWkEb0lxxa5zEQEeYTVpp37/qoZHB?=
 =?us-ascii?Q?ZBKcsTFsaMY5Tb1Q2poLTDYJCbLL6hgOfVuhBi4Xs6qxZyh/ee4KLRg6j0oo?=
 =?us-ascii?Q?M8sqxDiXikP1Z0W02CJ/3yh7IvDAYxThRVecAlPs62Fs5Qh5/VJ9PYPjg0Kq?=
 =?us-ascii?Q?oa5XRdy1t5UU3QICK8TwvGjMbYgcu21D72l+HedoH1ai3+a8QB+ddwtaTxMy?=
 =?us-ascii?Q?fVOO628gfR2xgDwCyDEJAiMQKI5hS7lVs5YPv7mMOvqFK97/tq1OaF+McXZ5?=
 =?us-ascii?Q?d2oCAQgyiwy+3LL/JZna4MaKuR6Jl6StsD/0Un0JQWhJL0WbuNsmM9Dg7x7x?=
 =?us-ascii?Q?LJRnnn6U55vXeJHKm0NL8Ox1qCNS/iUg0P7DMiwaJk7+CNlAXPvhacKXxSBj?=
 =?us-ascii?Q?mBWYvsFzy4Wk6l9FugzA5cZ2m4vTIFdVZR80OP84MqXZ2/asZPUgLLy2e55A?=
 =?us-ascii?Q?Z4Z3ef0kwUcHyEfhv4DdOR4aPhIP69aMnEVeYx94Rp7XhiL3OxTReRVm7YHx?=
 =?us-ascii?Q?Eg6+8PVXLMyAxvdk0JoDBAA7Qgh9nFMKwgt2hBtNeRUd7XRq4QwZrH+rDFZ5?=
 =?us-ascii?Q?UP7nWOY4WLwhNYyobPvcqEB0iTp8+qi2WHPsnW8Oz+zacwU0Q66Ibs4DWOS6?=
 =?us-ascii?Q?reKLJedrA6sn80OGOF5ctXguIP8og5sbnAKDXtBa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6429464-80ee-4819-ed5c-08dd420377fb
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 14:28:02.2782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NxYS0kdVaHSqQdbC0QgNuoUwD3v8fYxq1nHfVWwR+dbloQepyiHB7uHPTv+DV1p+VCvR52nyz2Qblxs9CY2Gjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9451

On Fri, Jan 17, 2025 at 03:31:40PM -0600, Ben Cheatham wrote:
> On 1/7/25 8:09 AM, Robert Richter wrote:
> > The root decoder address translation callback could be reused for
> > other decoders too. For generic use of the callback, change the
> > function interface to use a decoder argument instead of the root
> > decoder.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/acpi.c        | 4 ++--
> >  drivers/cxl/core/region.c | 2 +-
> >  drivers/cxl/cxl.h         | 5 ++---
> >  3 files changed, 5 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index cb14829bb9be..b42cffd6751f 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -22,9 +22,9 @@ static const guid_t acpi_cxl_qtg_id_guid =
> >  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
> >  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
> >  
> > -
> > -static u64 cxl_xor_hpa_to_spa(struct cxl_root_decoder *cxlrd, u64 hpa)
> > +static u64 cxl_xor_hpa_to_spa(struct cxl_decoder *cxld, u64 hpa)
> >  {
> > +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(&cxld->dev);
> 
> I think this needs to use cxl_find_root_decoder() instead of to_cxl_root_decoder() since the
> cxld is no longer guaranteed to be a root decoder (as per commit message).

cxl_xor_hpa_to_spa() is expected to be used for cxlrd->hpa_to_spa, the
decoder arg is always a root decoder:

 cxlrd->hpa_to_spa(&cxlrd->cxlsd.cxld, hpa);

The decoder must be converted back to a root decoder in that function
which is what to_cxl_root_decoder() does.

Looks correct to me.

-Robert
