Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48757222585;
	Mon, 10 Feb 2025 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739190702; cv=fail; b=BpeZ6unD/8ZBkcH8pPGxBKsEsImlrwZjNphKWS0gFg53BXsEQ+Yk/YjEyL+KzSw38XBFhgn2nUtRl/gG8iqz5jzw9gbUy7Rd656bsd/bWFlLcW6l/t8xCNSeyKJz84K+rCkLKq3qFDMuz0G/0FoU2zcRIUNdtaUuB+E2n+lL2Ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739190702; c=relaxed/simple;
	bh=q2AfMLxJ4YR5vxK3pSRI31olBZzhWU1JtMT41B9w+EE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=L0XM8LlbhjlnZI8x0tIluEdpmmMeNBbRDTGcttNS7xBcaXb9mMAr7l+oCXtyGLstnoLbRLebwcDywgqD505MvQE+XvbQFGR5sLK0FIT+rZtPMWC8sctrny48FIS+qktSnlQQoTxWVbLE6o2e922kjjyQruZ5NSm4PDhuZabaOFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wireUmrS; arc=fail smtp.client-ip=40.107.92.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wireUmrS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gnv6+nTyHvmVtVuLr8Yd/eihue6zXRRLRZIThZYzmtjp2sYGncYdEn/nYpkDKQT+57w8RtsbZSVHVOPhxbzLQ4EIOo/JXiRc5HA6TK2BV6rK6z/EhGRNBJ9fwor5vZ3bcwDPDoziPco3vjVlQT3NXpcCL21bbvI8BGCBWIPhDgZRSQxTmy+6IfFY2yrhlO++REEPIrBeodThtzQttZ6Vw5e3jO9HSvwUu0BZqf0vWCKEQSl+NupFNBSOqEKTAUKCl6ZNQgzQQfOE5YAOActjged5lR7tGoRkPBviknttVATX1Y+stBQOc0kkf5QxJY46LaO6PpfKtK+alo4DYveEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=00wQYKDG7vlFP5wAtHfjLzgZib/zdJOMrOMaEb91gUI=;
 b=qDOPgU99EP/3NOAZOoOy9ZzetDCeB5734O0D6qvZ1AxDK117ZqW50BMOvp5wh8E4dL6Tray2ptbcuucd5MHxJN5EW0tgTpi6Lj3M8vH94YRCplOBJJHU5IOz2prD803z+zFs7X73Y7NGvITep8oNM0lpm8Vp0YPtJmIM2N7IFzOMPFChdNP6iVKxAUlF0P7xNTUHUeHNsk37GBbz1GwBe3ifbrBBaThFPj0BpA6WQU0GJcUnWQcxNoDHruV7i381lwWtHvOlFSh6ZAFH3TUtPFaov8+8f8iUaAZO7wA/LtoLuUr3EW02JbQlrFwJZPeemlVMCEhvgljd7F78WYc/jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00wQYKDG7vlFP5wAtHfjLzgZib/zdJOMrOMaEb91gUI=;
 b=wireUmrSKg7X3dSgrXWwVIVDaeQ4ociCJebSWTQhCelP5wiXJw5w0sjhKqFPlPqhQAonWBTM8liOmybUsSYGXvYxX4NQXWI8xoR0z495FGwotDISlYPoNIWB4lcq48YxyUsMZZE6vbbXKRGnQMW1YTBg0kSK4g/ju6r/eczh2QQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Mon, 10 Feb
 2025 12:31:37 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 12:31:36 +0000
Date: Mon, 10 Feb 2025 13:31:31 +0100
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
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v2 13/18] cxl/region: Add function to find a port's
 switch decoder by range
Message-ID: <Z6nxo_tlI4o2I9jW@rric.localdomain>
References: <20250207153753.418849-1-rrichter@amd.com>
 <20250207153753.418849-14-rrichter@amd.com>
 <Z6aHjiROdVotsZt5@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6aHjiROdVotsZt5@aschofie-mobl2.lan>
X-ClientProxiedBy: FR0P281CA0110.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::6) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: 968bf7dd-93b0-4a4c-7506-08dd49cedc3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KVMteISWv0qj8WX42WK2tZgeWS8WE7NIlQDIosSmoiEDKyLbsQE2YstWdQiU?=
 =?us-ascii?Q?d9ZZM/ho2sZ/bR8GxlPWlQfRqGyrhn3GqWQv17wDK5Zug7jwnAGZty4nYbaM?=
 =?us-ascii?Q?+FoIF0AjpS9xRjNqnh2zj5B38qo+AzLQ8ri6SX1xPAOviGhPnDg7BhebRXXB?=
 =?us-ascii?Q?g2OSqqCjiFNg8OT09o9IaVtClrGrEEWF67inkOqj95ppnToa2HKNCOikw2bz?=
 =?us-ascii?Q?wRLKtrf8CnwvvD3KzRF/whtwJuY3I7b+esH4YrsPUPcfLMKgN+hEV330uoU4?=
 =?us-ascii?Q?xLHnmP6CcCGWEq84ub1ZvsIwd9oXuFnDFwQVEe9hIWGNRBcjHefteiiawr4F?=
 =?us-ascii?Q?D9Nwo9/DoXnv6pY+dtYAFMXLQ555+f/IzNnkcUmCBgJBLV/rXICE8ExZ2aMS?=
 =?us-ascii?Q?wZq7+s+zXzm0Gf4nXnO+o1/RbtxxtHKb7QiFuDBguMkuNdHvr8tmvtgR9TSJ?=
 =?us-ascii?Q?aBVprmEO2HMI3j+iuAfN489FLKuSSMtxonuAPsNki6NHP+PELZCJ6PTj+wl7?=
 =?us-ascii?Q?UI/TWuaYAeeOzqjl2wu2lescPJ8L7bWofGXzaUHg9qCN5zjtEdpfv+JuZNqz?=
 =?us-ascii?Q?Tc5viBbped6Tro7jsFINZUsYBmijPyEJJkMKLqPpkgooj41os9CCvZ4gGXg/?=
 =?us-ascii?Q?INn+UNM6QIpJ3uAeAWM2wJr1RyEAEuyTTxCHaH6q2S2ripk6a5uI0rp/vTHW?=
 =?us-ascii?Q?FY+01X3iBp/cxoOVDEKk13Z3JeK8pAR3o/35qA7jWTUf+PAB925kz4+PMASG?=
 =?us-ascii?Q?Gfy9COoEsoDLr/LW+jJmB50fIJVB6ubJF/eyJ+TYJWk+RlUKIhAYu/EOMvlF?=
 =?us-ascii?Q?2oXdCE6zNRbhNKyfx67zuoLQaSsXBgkHvz+CPO5S8EjdiUMS15SLK4rLbsX+?=
 =?us-ascii?Q?TBVCTlivCFU/Rl8TXVkj1FIBJpyoRD3sqcgZbz9KCa+gNNkoFHmSDQ1KTeAg?=
 =?us-ascii?Q?rdLcNv0VUsbDxzUe7nBKztfRtsCJXJo4x0hD3J/+AC+xlvNKKymbIjll83LP?=
 =?us-ascii?Q?U7dDoOFieyPiyqGYETSMw27hFNwRG6hfAVl8nlV6oUag1dqReVH2CTnJLurP?=
 =?us-ascii?Q?AJ2konQRFTGRZKXFXLT4oTz4cfqG5JQ+agwN2k+1ozYCY+bAdMeX+kFjTm4t?=
 =?us-ascii?Q?wM7crlURNmrM+aaKZpurrx/0Di1zdoK35GoDAm5qSRJ/KJK1hX5P5g8wrFz+?=
 =?us-ascii?Q?5vF3EcPhceRoc374J9Z8jJC43geStH0enJj22qNABBOgArK5z5refh+uceZR?=
 =?us-ascii?Q?giYxkGxWS0OlrW5O6DhH35QZam2VoUDLoYRpbDp3sP7eGj/ftkWeOl/HFOrE?=
 =?us-ascii?Q?WdH6B4PkCFxe6o0WyStYYnVvrZHgOqF3Rfu+7Uq5jlAhBTHKdNMKnKXxXmiA?=
 =?us-ascii?Q?JlgWS/b+GnOHJGO30sF3tishCLzr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tnTscFQ9SnIHERmpqxBV31k/GAD+LMj1bqWM9BfxjMDJ23Z/9vDfeOFlekT+?=
 =?us-ascii?Q?ntxf9BnkNh9ywI+BBe2mS7Qov4ZE7vGO2zYbxRL9UqRl2D87tn7YVBf1vPxD?=
 =?us-ascii?Q?jumjpFiD9iCehx02uH5LNQ1dc7xZZdPYfff/OsmCLaPCoyMeQLUjKe3XKagr?=
 =?us-ascii?Q?s0pVtZUH988QYErWWFLs/PfZ1ACtDPpKg1BgEyplL30KlFqxdKbYvCQ6Gs4n?=
 =?us-ascii?Q?9VaRXIE3FOWS2Z18lEz45qiazoS14hO8te1l7S22zSaTYd1JF2Ak6bdVjoGi?=
 =?us-ascii?Q?fLcv4t45I8aw5oIbEXPImFGFBh1zSyYFsZcwOwf3PAfUlBKFM1/y4l166BNf?=
 =?us-ascii?Q?3nk6RRo2QU7RMNHzIZ36VyB63SEfR5WU48v5IDrNnYhvDNxJjQVJWHta/DaP?=
 =?us-ascii?Q?SiWVUeq7ZixFpaXIgUzgOOPEINt5zVieizflg4C5M+eYk7bOtS2Uohc6AivF?=
 =?us-ascii?Q?eay2RhU04xZH1xAhYWkeSviT6GI50SYY5b19+Ub+XNjcsBz+lENP+N//b0Tr?=
 =?us-ascii?Q?T5PiEZM7Fpmfwwdw3j5mC3zaveOIxsIlE3JoVwWq/iuxaXuP3GPWrzQIolRD?=
 =?us-ascii?Q?dOY+jlnwnGJNgRD4MIP+cQx3tG1YK7jjAsgYTRxVA+E1tqEgDPiHgCE3hKgB?=
 =?us-ascii?Q?jsOm9O4AstcOBUwKtiM8MzXnawH3rlq4LNSZ3kbXjwtwIp6raVSBPirYjhdU?=
 =?us-ascii?Q?Q0tz+dAa4GmSR3ycwO+NmQCgSjrd2whj8AX5zZW1N6wq0jrexw5DzxCKA190?=
 =?us-ascii?Q?+yCG0uCdqgiEoAZljzRqHxMyPstLD+OF0CsKZj+wv2r7XiIbgAx0bEAxxL4l?=
 =?us-ascii?Q?IGBKDcpyta8MrakY+/O7PQF8VmFPCKZeiLr91D0lYiAvbQeeceEn9RtKLs2s?=
 =?us-ascii?Q?58uVt8HTma9BnkDUABamlg5AQ07V6CUagqlToUl/7qreb0YyF7jbbgEhfWmN?=
 =?us-ascii?Q?5mnu6ZH9vwiv9tb8WUH82epPKgrkD/S4T/WbuW14kFawwDhT9EJj1fZhJ+gi?=
 =?us-ascii?Q?D9m3Gx2in+1R6W4br2v0iXTGK/g6Lr8UJK88OKHbDRkehytaVeQR62ABZr6Z?=
 =?us-ascii?Q?tF2Iptj3zfubWFZ5WOBcMyItDXW5FkwgqIi3UiOlyrWMenqNRynjRP0juTRF?=
 =?us-ascii?Q?1cTRlzWqoce7d8Y4RDdHAu4lsLynkASU4EKJhz2WENGIW92pTnTP05QDiPOg?=
 =?us-ascii?Q?okQKfbRyT2GefNmJkjPwHro79RRR4LEQyRHUs+FdOR+mSaee4s8TSXdYPrHc?=
 =?us-ascii?Q?09ALhJU5YP9wQ9zQIWVO7IK9himJH6AC55JC757ZjEBMRxe75xwzBbv859du?=
 =?us-ascii?Q?/FBVFoNXO4QikYonhEJVTPz5rZNzDutZSek2Z8/l830N689R3M3j5mR3gjWQ?=
 =?us-ascii?Q?tPHFu1Sh3+MVaCd1op0bkIZP1ElJMcUMwpbmHvvNvU7p2UroSPieGugwg9/B?=
 =?us-ascii?Q?UX/1DCwMV3IXfq5DHMY87Rqm8eFn4ENcgUvC6/HHFgMNrMb5TgwT0A6LBjvZ?=
 =?us-ascii?Q?Hw0OupX9f2dHsEXSgSX5DGN63qg/CQP470ImOUXPYE7lsT1h4Bru5i5zWDJX?=
 =?us-ascii?Q?SwZthtkABnjYWz4dUADro/V+xCv7zhPumLNP7Jp1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 968bf7dd-93b0-4a4c-7506-08dd49cedc3f
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 12:31:36.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6/uP9QfEua82wrHhJ+yTCnVvVi9XPslqVQ7nzahlc9EYjnLps2KSWyN1nDr1wktSvXTY1c1CePNT+6a27Tydrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806

On 07.02.25 14:22:06, Alison Schofield wrote:
> On Fri, Feb 07, 2025 at 04:37:48PM +0100, Robert Richter wrote:
> > Factor out code to find the switch decoder of a port for a specific
> > address range. Reuse the code to search a root decoder, create the
> > function cxl_port_find_switch_decoder() and rework
> > match_root_decoder_by_range() to be usable for switch decoders too.
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> >  drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
> >  1 file changed, 27 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index cfcd235f311e..15286acdf6d1 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> 
> snip
> 
> 
> > @@ -3218,9 +3234,8 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
> >  	if (!iter)
> >  		return NULL;
> >  
> > -	cxlrd_dev = device_find_child(&iter->dev, hpa,
> > -				      match_root_decoder_by_range);
> > -	if (!cxlrd_dev) {
> > +	cxld = cxl_port_find_switch_decoder(iter, hpa);
> > +	if (!cxld) {
> >  		dev_err(cxlmd->dev.parent,
> >  			"%s:%s no CXL window for range %#llx:%#llx\n",
> >  			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> 
> The dev_err() needs cleanup to align with !cxld.
> As it is now, fails w NULL ptr dereference.

Yes, fixed in v3. Thanks for catching this.

-Robert
