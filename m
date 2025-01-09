Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038B215793;
	Thu,  9 Jan 2025 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736417698; cv=fail; b=dA7VJweRka8MnvncZMA4OZPoQL+lELO5uLu5wlIGcwhmujx37T/XVzpkaHA2K3Dx+KmrpIyrJqwYxPhcKsoveVAv5O1q6wMGdGziI8XpVKh7/VEIOKONFGwiSfI9Qgt7EbfGupa7rRQNktsUIk5mIXrUT9eqnAS78yj8JlMRZ6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736417698; c=relaxed/simple;
	bh=TXAV84PWbLrvOVoQPkElII+/LugyKtVLbZYl0uWrZkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G8k0d+VMk031YyqYT5hxs21X7w80PUgU6wsarB1YpnLd01MJYGKoCUlwwH60+LxQO6v17/PI7yLTgmd+701uSq1gEcVW1l1z2vsVSghXTbW+cpgEyYr7i6OcW+3T5LHXwmMxz4Dto/dE9MIidQ89GKr9f1B7aj/z2aH3MAmsA3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iXDzphry; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iXDzphry"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJJZnP3drC3zL3jPH0FOa0si15LfRkhcd81uiG5vqbPHwrA8xEW46zbZOEQ8uVSquyWbKFDRVDaZORKyUcI8hiNilDbej7W3YP9LwMzCiGzlcYBSFhTZguIAEUI1yECR0e/q/NEPLA4zuHTVgRtyJcgD9cHOEKDMgUuaMYzG07QaFs482NOXvyjEIyNw9uz0+jPwhX746M207EnZ5wtxNIG/qtmtq/E427PonV0VE6y5jwm2lZe/yS9IBaVW8ocHIrtJXUH6Lj3PQn3BG5LiRY5sM9bQMj2d9GJc6PA8XGMn/UgHZ5Fbw253PA5D1sxcZdKXvBJoSFqYf8OEiptr9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gS1bIdoWj20oCQwtNaUYy0xUa5H/94Gd0yPrxHdGkYE=;
 b=rtbbv51kkmZJivWU+6n+Ak4JVy96qFtSHUp5DloWILboLem9rzujXU3bVt2KYQmC00UkZGO+3GG5vfmodPJVp5++4XWu0C06RE2p+Y79wK+Chi2u5kMPhF99n9Eqs0Py+X+qUoA4LOn1laLQ+Y87aHlbkWANH6+qInHYw8K3OUdmjCtDCZETgvZAuXVy3UCGW4km7tM/s95d9qE9zWi1O7zEUULaWvY9rMa8X7vupcxZlQwOWVAiDN8T9bv3XVC+oqp27jiV45PE0sfUnynPj08Qgw4BUQJpzMSMETlHiVX4aczZpGExAjaszuXkkGr1rTffaeXlvuUJHy/KQTeEiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gS1bIdoWj20oCQwtNaUYy0xUa5H/94Gd0yPrxHdGkYE=;
 b=iXDzphry5FmSE2W128ZAZrJTVQ3N8CftAs3ipb90YLK39Nurn0tAu4Kld+Q6RpCd1dL1TlYqOh+Dhg1Lj2kN/8GFm1oftRD4ko0Jrovx3wpFGKBm0Xl7EYAfZEyaqmSACh03CL5SksyErkN7jokK7eNluMgfPR87z2k73Ek9czw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by IA1PR12MB8237.namprd12.prod.outlook.com (2603:10b6:208:3f3::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Thu, 9 Jan
 2025 10:14:53 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 10:14:52 +0000
Date: Thu, 9 Jan 2025 11:14:46 +0100
From: Robert Richter <rrichter@amd.com>
To: Gregory Price <gourry@gourry.net>
Cc: Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: Re: [PATCH v1 25/29] cxl/amd: Enable Zen5 address translation using
 ACPI PRMT
Message-ID: <Z3-hlYh3voRFLG6o@rric.localdomain>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-26-rrichter@amd.com>
 <Z36eR5oXcv3rpEZ-@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z36eR5oXcv3rpEZ-@gourry-fedora-PF4VCD3F>
X-ClientProxiedBy: FR3P281CA0117.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::8) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|IA1PR12MB8237:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e8686e4-e59d-4a14-8927-08dd309674e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RWalYfhhLB9jX501x4FNEvlzSkWJkS7xHIuzpagnPYJkncm/7PEycbYjH+46?=
 =?us-ascii?Q?e4/h02Sr/OXzjghAWN+10qzLU4bJc/g8v+FXlpRbBKnXdBc1uXNlX5SaD8xD?=
 =?us-ascii?Q?6iyUmzYtsFvoW6TjPlSCDuNP3k1JzCyOwZKvpvc5grnTpj6t/te7F+D+7bLo?=
 =?us-ascii?Q?P4cylyXlP83NcSTmaud6lRzA2UJhH9HQ28B83blYtJyOZEPplZrMv8TkhQcu?=
 =?us-ascii?Q?GNOYVVTPllxTVAp4n/vSaRuieX5MJveRmVV2l+lwpiZsj3FoAg3Cw/xj+EDx?=
 =?us-ascii?Q?1+c1zqk8VE0ftjeb7W2qRQKlO6IKRVXhsKy5kdeEW/cCdccozZjrWheVPe59?=
 =?us-ascii?Q?t1hu58cWr8KgSVHSX726amNBQbUFalesMoLhy+9KPJ7e8XmYtR0TJVI9sYGT?=
 =?us-ascii?Q?73nNhcpluDq2GSxXZ2ot14z3H5oa1HBRDHC6JG7OUBIvcR+A0rXN+F/qqj0X?=
 =?us-ascii?Q?2Tsleb8LUTYWw4isijurvZ5yeZq1cnrq4dzrShSd2+pLPlHzOyhqj+KhDOpB?=
 =?us-ascii?Q?qkY4q9dcVbJoee1QMIk484XUqSeNYhZm8GoSUhun0W7D/pP0WSz+DK4jLCj/?=
 =?us-ascii?Q?IdwODUQq6ujptvChiQaqsKJz+i1gDSV9SQ5zXJZgvAxJ49LwFxiwQi2qFHEM?=
 =?us-ascii?Q?IYwcu94Exam9kkHRzuVpiLvqmOF8+nvivysr9quH6dCr8CqRICEibDR5NL/j?=
 =?us-ascii?Q?WuuRGMvfuOE/Zet+PkN/vglE1353YYVSDeVL7ceEHHHBgjGFrLhFRyiNSl54?=
 =?us-ascii?Q?gBB9Jxnn3t8dQtjRXbGn4OBNVlaK4XF+VkW7U8r7r1MDsC/BfI7Ul9D0q7jm?=
 =?us-ascii?Q?VhpRSG+Gjk4g+598eHsX/dfW1UBEnPkZlyhNUX2+fQAZTPLNZ/daZDLzG9oh?=
 =?us-ascii?Q?2z8ivV8+kue0BrE+BId4v/p2IlnqCNILc3m19u3aS8L9ExCoPvqSq9p6gNW7?=
 =?us-ascii?Q?UBAQu+Lol9nDG8rkOS5RM80Xo7N88/sgEQuW89ytaoVjSOK7j7wESDCc4Yuy?=
 =?us-ascii?Q?iA25bUa2Vbu5rvbw9lQi4b4tY/9gAutcSYGGH+Z3e9ezCuaJk/rikVGP4I+A?=
 =?us-ascii?Q?4CVTWh/QcYtz+l5eiGP+0Vg4TPl9GjBfhkDNUbd3oBOcVzt5eedoNnKNkUrS?=
 =?us-ascii?Q?xSTOFELCHXuhZtqtwup6eml2diRl86FFY2tYtO/CMOPu3JAihss221ln8x8E?=
 =?us-ascii?Q?RqBWRVUQ+xt0CxY+xP2GhroeYXcDz4vcBn4mCeP5xmavZJyF69Ih7SycX33C?=
 =?us-ascii?Q?0s+HaR6EZ2o7nSflqQJLH59JTXVR2dZv8mSTgNx9TSUHRm0Fb0tKMFyBveCn?=
 =?us-ascii?Q?J4sH/bjVbqkX/UpljdzKsjXyL2HtDNAgSZXnrOI9AeVYrt11CpSJ80HaJV1a?=
 =?us-ascii?Q?wbP7obY61DwzSk/9ZYCyEHLXC1u6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PH+xOUZw3y5FB3GoZ5hPESmizK26WqQW+k3uyAxaa0VqW5aBiCfzkqyqedAr?=
 =?us-ascii?Q?igCOvFASV5sr64XVR4bgIW1/I1lQ1A3N1R8Q/psq15wP2En8MYlsYC6tiHv5?=
 =?us-ascii?Q?ASV1GQp6VHdRArCHkuq9wozRTfbVL1xe106vNESwImjDMS9ehh7E1xEohQPE?=
 =?us-ascii?Q?Eb5B7t8lb7Lc8gZsuH0/ZuyxMSvDV1VNU0CJNB5CSpHbDpfHWahLLV/GkSfN?=
 =?us-ascii?Q?ISi3dZP4V4e2gJGwGMX+gspiWHqwhTC86BfAyAiiDfL7F5qfvjnyZ6NJx3qs?=
 =?us-ascii?Q?4idMerfQMNy5yfKqbrH/B/p4Coq3uBfBYiSl9cgn3JEg+nwT+v2/M8k+8+k7?=
 =?us-ascii?Q?x8pv6641otyYQRxOltbutBfM6QFUQ+B2n75Bb71+xVmfKzGtvIJ+ZH2MZKN1?=
 =?us-ascii?Q?pxDKQzekS36UUo/62PaRPU4CuoAvuRjujqsY17JOuimk14OY8NLFd9rAj9UI?=
 =?us-ascii?Q?rfBluMvdR2QghQFYveRzlJ6LYck8Iv+D6JwseNhQXV24zv+5PiNjRWnWuTgr?=
 =?us-ascii?Q?CxY5qRY96OO6bf7bEWW+OPfUperKjQCc+hr90r4FEE+23i+pQLfdRosQ7fD9?=
 =?us-ascii?Q?36YbeOzl8iVCVNJn1W71M+3UXl1CdQ9mYis1kwcYEuV8uF25/1kgcS5OCRe+?=
 =?us-ascii?Q?v72KD7HVGurADHHdkJkeNH/fDw2Cxdtf6W6VV1swSBlXAHgOjbGt9lqCo8XI?=
 =?us-ascii?Q?3G7Nx+hTjB4izPKU7yhxFDTPdrcDFMuO+wC/IefWYAVeIHolNzIjauPTyISe?=
 =?us-ascii?Q?9K+6dgRKNI6X09ELZnE4GTNZvtBQcQooPE6ilTG28NtS1IvNyDTcZkB1XOk6?=
 =?us-ascii?Q?KKCQM8AVUZTAuhiOAaiu6f8ztXID/SeBwXe1diOjXSl3FEJudcP7X1vrk4c1?=
 =?us-ascii?Q?dUbP5QP5z3jBkwns1HnSfYKT2fCfuEZF0UmBG+UfE6oUc+cJH/njx9lPOGQW?=
 =?us-ascii?Q?XfNmSM1YtqhsD1mzmKbq37hi4lztpleEIocmwKD7qwo3/C3shs+3vS0OjGf9?=
 =?us-ascii?Q?f4xdorxRtRmchYdp5Q2lZUvkGblW6F058VPkvy0VH5f0gKbA0Sf7oKRjCSnS?=
 =?us-ascii?Q?OAxUiQuWOPgydRdrboV5q4AliGb9vAtwO44QVjo34V65tXbTQjHAHlxFOPde?=
 =?us-ascii?Q?yKCWItaez5PmPC9A62P3YgUIbj/JaBQUhvawxHyXfoS7YltjdP3q23gw9OxI?=
 =?us-ascii?Q?s3kWv6boxb/B2NyzXEHVLvv14Yiv565/HuEtjOajOznKuPkIrAggmBGEYbTG?=
 =?us-ascii?Q?kSXSHD3TkjxdbDzvuTyhyF0oW4I08HeSH8VOD4+iY76X6+ETYcPkfgrMdvpS?=
 =?us-ascii?Q?O7PiZ/J06+EzpbHmHvL1riv5KpAoTFlRBw9xFZvAMt66L41E9P1VLW+jBnIm?=
 =?us-ascii?Q?gCcuVJlMy0frkouQNzBhYxM3h6PBNUY7NZ8+W1J1dhAUd19xJ7vmd1gAVGfU?=
 =?us-ascii?Q?zI9P+MA5d+1ZiS5LqgGHY3zX4zQ5OndLfQtVy0xaudHGFmhSyA7gJQAFY6/L?=
 =?us-ascii?Q?OH8w1//APXMIVR31219JeG8khnY2OThseD9Qq4zPYm2ae/dJok3RY5CsfHOk?=
 =?us-ascii?Q?OJ5SSS/s5e0Cml2RxUEfVU7+WdmHnNu2Nr7QfCjD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e8686e4-e59d-4a14-8927-08dd309674e4
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 10:14:52.2280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TEqfh2fPKv8zFsN6b4iU/Mz9ycfITio9624yLcDWtKD4D8zO3Ic04uKz8jmYlQ9UvppxbOMJCV94Wv+SNbyjrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8237

On 08.01.25 10:48:23, Gregory Price wrote:

> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index 901555bf4b73..c8176265c15c 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -831,6 +831,11 @@ static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
> >  			    &cxl_einj_inject_fops);
> >  }
> >  
> > +static void cxl_port_platform_setup(struct cxl_port *port)
> > +{
> > +	cxl_port_setup_amd(port);
> > +}
> > +
> 
> Assuming this gets expanded (which it may not), should we expect this
> function to end up like so?
> 
> static void cxl_port_platform_setup(struct cxl_port *port)
> {
> 	cxl_port_setup_amd(port);
> 	cxl_port_setup_intel(port);
> 	cxl_port_setup_arm(port);
> 	... etc ...
> }
> 
> I suppose this logic has to exist somewhere in some form, just want to make
> sure this is what we want.  Either way, this is easily modifiable, so
> not a blocker as I said.

Yes, it is exactly designed like that. I will update the patch
description.

-Robert
