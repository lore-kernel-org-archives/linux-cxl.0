Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF42B350A21;
	Wed, 28 Jan 2026 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769605452; cv=fail; b=S44H8FOmbI8qMk1kyq42dXlZxGOQw5qgyINcpNsCIKaj2VgbMCHNeg9OlnLVE7iEWxfSubSmalyJge8B8fOHIXBYVvwigArtYPcJGK8STO54dnqUb+QfrYq+IOgRxt3WC78JDtEV7yq8yqte5/U2vJ8kHDUo+GUNlkpytyqcXhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769605452; c=relaxed/simple;
	bh=0xteq5+YtSEj9LgJU4lLjBTMjCLpvVjmU0RR9ykUqLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=b+r5JhOlSIHkvsUW1sUQVOIZ4dTCT7XtnUjRA4rJDSgF+CEEoJPWqRxZnIgXLFPwwSDzYb2yDGFIN0WKmuWcFXTfW0zGTwHjOg5jsRSnm4nWaHonILMYI02m6l7MO/nmlZ0nhMplIS/q5xbtvinQXtaE1EXPA8+48oVlQqN7lAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pY8yBq5v; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pY8yBq5v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6Fa1EiTmxz18pxuhnnRC/A2Y8YzGi32Nde2m2dM/aYGdiCfRCSU9ed6zVvh0bILJPzst4p2/fLOt4NUD/2wcEKdUNAnhr2oTMDcOUs2AfdqO97dZap4dFF1uGY3rAAswtUa8Q2xVAPflC1xYGTHdAEXbDCPDBxMFKpluJu3Cai5/G8PHT1Lxz/IoO+VPFqyfkl4jwwcKkJ6GnrBRbxx1U5xQXuGOj5m9v8eDcSbZWBpun3SGj0aEX8RG8cFQdKfABBOGPNSsEYMBgG7hCJz0G++tHPet66S1onxNhxbTR/9Ex8qNdpPyJRxII+Aic8miC3+z3Fz6O5uLXgsfxHgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4sjZfcaU+B99wGC07ik7zxWmaQsNC9WSyRx1YuAN8s=;
 b=lEvZRGZt+jAGuf0LcuG5CXq+jzfCh3zeKyLaUflSdom8Wx+xFUe3bF2QXlieUpbCGVATTJaZr44PwTGTumkkc7pFGteW8WKBb+sOFpiEVDsN6NwBbGfeGQwPNVeT1ips7DGoFQQ+XeD+U7t/aSsjImPzeCkeYHR8WzNS+T/dkpJQtVIWGSdrhH9+MvoHnuA4oVdQEubasuZuXukG2L2LztUibyRznbUc/Zo8W7KCgwrwgRR/W9BjK1FzCWexG2S8E3vgdVcYxahfkWHMEsyBlN+ut0eXM6Q5DlVdmDPA/utV9Ygazz3FKiy8M/A4uNKVku19udfdOe6JRLSLtqlolw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4sjZfcaU+B99wGC07ik7zxWmaQsNC9WSyRx1YuAN8s=;
 b=pY8yBq5vs7uyr3W4OfkyB5ApBxLmAelUeTVSjZyHIK2dXgr8f7kF+VM2u9jxtbsKhrK8yMsfJDIUA51Ioc6DYnrPdUL/vlC4qN1w8diPy/F0qrhk+4w+ymbh5ecv70ZynhUDS176OGCf6yLICmhA8c9dCGURJshtwlH/ON0hlPQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by BL4PR12MB9507.namprd12.prod.outlook.com (2603:10b6:208:58d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 13:04:03 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::488f:318b:ebd1:70f9%6]) with mapi id 15.20.9542.010; Wed, 28 Jan 2026
 13:04:03 +0000
Date: Wed, 28 Jan 2026 14:03:57 +0100
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
Subject: Re: [PATCH v4 3/3] Documentation/driver-api/cxl: ACPI PRM Address
 Translation Support and AMD Zen5 enablement
Message-ID: <aXoJPP00R7qblx-o@rric.localdomain>
References: <20260122172432.369215-1-rrichter@amd.com>
 <20260122172432.369215-3-rrichter@amd.com>
 <69790b8ff40bd_1d6f100c5@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69790b8ff40bd_1d6f100c5@dwillia2-mobl4.notmuch>
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|BL4PR12MB9507:EE_
X-MS-Office365-Filtering-Correlation-Id: 70d08cfc-8971-4673-b083-08de5e6db5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?g46cYHyWOviEuUBxX7q2Ww2l5uLGyaP/CwmHn3KofxAn+6MAAFCy0P4iJsQ9?=
 =?us-ascii?Q?sqd0YCjjuVoTKrlCA7KYNmBGYzzn8r8LhxUNbDDnbFIC7N8qpJQC8KI/EKmY?=
 =?us-ascii?Q?Hv0//pwUwiGkN6EclUwfEywihOJ4NauY5cCKch4uRSswii3WAEubRiKf1BfB?=
 =?us-ascii?Q?TYWsT/2rhWrnNuIZcf3G/zkuQFbps2aXl9PnZkxsYsiEzk6mtCAEzAA+6u6L?=
 =?us-ascii?Q?8clIQg95YcUg9NIB1wFuSYnc38Eihq55XI7z2ejYniL8F8fzMyzophyzVZps?=
 =?us-ascii?Q?gzBM3voOarieZTJYSwAe/kZAp9sLK6DWd/yDJHpHkE/WBjsBOEJeratu38zr?=
 =?us-ascii?Q?SBV3fRn4gM4xZuz0V85vOTfy1sML12poCbxwYdC5APaTuXxgc398POdnDxdy?=
 =?us-ascii?Q?desXxWyX2iYUlN9zE9kk+vi6cdREaBcrUtSW7St6qzXJzbDjp7pyxtSWCuQP?=
 =?us-ascii?Q?fDXDaRpUnxUexldS2yNS6h6BX96sTgvNrUWQqBsrLmtE8lB9eTW9fJpyPMfF?=
 =?us-ascii?Q?bY02XHV0Zit4pxOkMycH00zGkTYpfLS8NnT46PIrMTYsSUHepaKc8OCdsttZ?=
 =?us-ascii?Q?VYZD72HPvuu2Wv4+JGlXDm9h6sPin8V3Y+qergrgi6hdN/t9yzcrTBtb7OqK?=
 =?us-ascii?Q?7TncN3zFr9snVr1buA7REtsMsgfwOT1PjVqzmXbra1ZN9iGcCafcHnCUEpAu?=
 =?us-ascii?Q?LArPGM/CJ0FPJLmyeIJf4V87dfYTXAV8eNn54Nt96LpxTflt84IQ9q6SvMjQ?=
 =?us-ascii?Q?F78CU2kBZUDqXAjewb69iV7giZ8t98p1ntdTl9gQKzaZkpBkVOQRPMS+7W25?=
 =?us-ascii?Q?5Z61NdiAcz/TymfBIKTMzpWOBT6vbys3s9jAg5Mxsf8e5YtQR7McXRIXzklX?=
 =?us-ascii?Q?PwgfvnSjbNOIO8HmSztrYxZxmGOJ5qTva2EjFhJhW03Ufm3UQ0Rqj8oKtd4f?=
 =?us-ascii?Q?zL/DNS4QQUcL0XGe/FmUzcmi1eIWFjA3vs8S2EbQAIkCSkfdclHm3tomjMrh?=
 =?us-ascii?Q?pC3c4+p1gyVMF3BZfescizJcdPyY4qucw7Zx4sUFEjhzkDi3YncUpvSfqF+W?=
 =?us-ascii?Q?baP1X/0ET9GR+zSAlamJHhOgzG6IXckbHfKfYr2go3EUZuNMsUoVuXW3kJ21?=
 =?us-ascii?Q?xCxAHppie2RQoAKIrwS+5h8AQ3CF7ssPGZ5nZrhp53xPBT5UfVOX5aSWmGwl?=
 =?us-ascii?Q?Gcgfb5Lap6oLTiOuJFDxWEn4OnUdt9CGzkSJyDnQ1YvTXJoReWPd0zEkoaWh?=
 =?us-ascii?Q?pFDz5MxbwYkVhRvEv0lbnyfqj1hxHzeUp3r1eU1E6olPFLtsWcjZin1GzhcH?=
 =?us-ascii?Q?OuZmt7Tq0yfAzAG4Wenr+oWT53fNU5nEUQZnRYXV/ge2CbwYbRlupsx8U7Dk?=
 =?us-ascii?Q?kJKQChx3lzfP4S3ZgfGJ8rEjOfWEE6pDiLEdrHoKJuM0SZzyn6EuoIvsGW2w?=
 =?us-ascii?Q?1lJ3dvApguyO3lZfSR/lbgQpi3Bx+PAo1OpeV6jhDAdsBtcMPIZGOnSU01Wa?=
 =?us-ascii?Q?KHuFw8CRMsLBYiKD7OYNopqFxJ/ZDR315ObV6UFnZwXsb5DMRDuB2xMDrvSS?=
 =?us-ascii?Q?jQFnsZsdMZNF+NomrJQ84T4Aod/WX/rmeECAKpZh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?epD97Ywekh/IX7axZ9w9zjBvkao/zqRVbnlHRZ8KOvObV7oYGCVIRv+MUw9t?=
 =?us-ascii?Q?ow1GfIRLuH8FTroSAQTiEIW6smXlug2fKRQJPATCp9fkjg6iDWaQnX9c0D0k?=
 =?us-ascii?Q?tj2wQlmVopwqcwtbIscCCTN0in/6hI2dYxWV4ARlzkEpnNIfnq4gIVfKlNLU?=
 =?us-ascii?Q?kR1cgXSt/AkX2vQ0Nk39OYI9VsxMB+svIUhDSfh95XuemkSHb/vMF1hoVvDr?=
 =?us-ascii?Q?z8xfxMrPAMDHzPvx1hmEt7EVA6n2oCprdNJm7wmNvpD0kweal3s9LSUitCE+?=
 =?us-ascii?Q?FDL7rg6E2GvwnxfpEu2fhETX2ziPYdvxDE55dvR+dwepc9VL5MhPD/BWsl8C?=
 =?us-ascii?Q?L++schIfC0ZAc+4da3pA7bhMENotuue44BeDQ3mAvACD+uMty83G5vB8ChgX?=
 =?us-ascii?Q?/tR4141CkZerg16zoNP1b3YJQSf6vAnuZ+uoM1Qd7IEjEFRpUzwtUdLQaMky?=
 =?us-ascii?Q?VcH4hljqjdts8cRVHcE/N23pVRb4mQh7DGR7ubilK/4z2m60vA94H9LD7dw6?=
 =?us-ascii?Q?OxqAX9Iu3wggYMQGmlNBtWZS49yk4QITIFV0ppsIC3JJUf9rHcAIo5995C3w?=
 =?us-ascii?Q?vYAH1uxQirhLsGQ98nzJjaIoffRNL7XiaknPM7g3TP2C1VMTC8NG6D+H/iYm?=
 =?us-ascii?Q?3d6W3Z3gVYyfBL0SCQ/rRvck64lPrvhH+PMmr9Pwz//ZTJI5dbzuFyxGV8fq?=
 =?us-ascii?Q?0ZIC+Ff0iVOuBJdToskAdYLgQy03KuJS48DfdqfkO6kVswteUc74TSR1bdMx?=
 =?us-ascii?Q?eYf/DxuScliB4Pyn4E1Qgtvb0PpZaIfc33xLHgjNHQbxNJNqSfxUeLou4uDt?=
 =?us-ascii?Q?FwqaolkU+4GfnTqsVgJ0rP9eEHGHUqsZeMnRoyJM9V3yYXNjOx4KoXuhstNX?=
 =?us-ascii?Q?qRZAa7tuOjTLdyO9PUQDCKI5HUEIozQ8wH6Yy0maNQa1nkPgj2W3pvocT/iZ?=
 =?us-ascii?Q?MdRLuNJvILUXUe5F7JTZ9/k3OyAhGqXvDEGd4qHmYyeCsztVg3TfMegS6mx7?=
 =?us-ascii?Q?8Kf2DDIWMSOJDkfIB5bPaxutT/itbkt68PTSwsSEqa2OQcXqckkocnw3tx6T?=
 =?us-ascii?Q?QZQBgXVptCFCIiR9QD1aotkYLMPQl7Gml8odEWrkzDlZxsN3SIU6/XbDcsOS?=
 =?us-ascii?Q?8WUzUcQ3sbYkX+OUcEzA+EIbf0VkOfdjCVTcjbQ30s7h/lcUkDy6PZ9lgFnS?=
 =?us-ascii?Q?JAKz6Sn8Hfj5WZkmUresWKOpe7eQ7Jvc0tBdt5+WvjsOiXD7k1ikFuHUrwfl?=
 =?us-ascii?Q?XyT4aC/Pq7Wdra2dzjPuuu/cTW50l62qwC3oukpUAzi1FgRAILBcU6LczXAI?=
 =?us-ascii?Q?oSpheT0QqjGNY4xfUBQX20quK8Cx3oEqL12mZl7mpA6bK1t7Xzl27QakjGnA?=
 =?us-ascii?Q?gyXk5EN2X3TDNNEOMvP6Gju+m4o8DpfbeWsH15A2uDYBnx65hBU4e8pXwzY7?=
 =?us-ascii?Q?SMVA2Z2JZ/584dz7oI6KRjzBdgMaZ2lqgnenVH3kp2lbXYEBCCUbaBBsRzmm?=
 =?us-ascii?Q?FuHyU0qljwQfTeFnWKWPyZa/czpWaMru6n3Yvg0wxfVu5EMrnTJfMx/FpchX?=
 =?us-ascii?Q?MK7QI/hYyPoRDvQ8j/SEPVlblIF4xkKpzwelmGM649if2nxuENhCKBMyvg9r?=
 =?us-ascii?Q?26TaWp3XbQ1D7h0O0X/Xx3JpVI7UJDPwDXLLeE7zxjyqtiIVDqkvY984G99y?=
 =?us-ascii?Q?l/8Z4G7TKnxw/uIJOlfvC3dxIksO7Pr3M4yxXlLBTMv9hrRti7m3p0prLReW?=
 =?us-ascii?Q?1FM+KtHNgA=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d08cfc-8971-4673-b083-08de5e6db5db
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 13:04:03.1311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9y867gLrA271a993PRVWbkq6iWTVGQmJ1V+ZregpxtEX254QLQml9Y+41cfYO71EFI/dLsfnGPtfJgtvBApwqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9507

Dan,

On 27.01.26 11:01:36, dan.j.williams@intel.com wrote:
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
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > ---
> [..]
> > +Detailed Description of the Change
> > +----------------------------------
> > +
> > +The following describes the necessary changes to the *CXL 3.2 specification*
> > +[#cxl-spec-3.2]_:
> > +
> > +Add the following paragraph to the end of the section:
> > +
> > +**8.2.4.20 CXL HDM Decoder Capability Structure**
> > +
> > +"A device may use an HPA space that is not common to other components of the
> > +host domain. The platform is responsible for address translation when crossing
> > +HPA spaces. The Operating System must determine the interleaving configuration
> > +and perform address translation to the HPA ranges of the HDM decoders as
> > +needed. The translation mechanism is host-specific and implementation dependent.
> > +
> > +The platform may provide an interface that can be used by the Operating System
> > +to translate a DPA and determine its corresponding SPA, such as a Platform
> > +Runtime Mechanism (PRM) handler or a Device-Specific Method (_DSM).
> 
> Optionality is not a standard. Linux does not want to consider different
> vendors making different choices. One mechanism per concept is the
> expectation.
> 
> In this case PRM is an implementation detail behind a _DSM calling
> convention. I would much prefer if this implementation did not directly
> invoke a PRM handler and was instead always fronted by a _DSM. For
> example, one way to avoid the pains of PRM would be to implement it as an
> AML method. That is not possible if Linux is directly invoking PRM.
> 
> With the change to drop the mention of PRM and just document the _DSM
> protocol you can add:
> 
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

the Zen5 machines only use the PRM method as described. They have been
out for more than a year now with stable firmware. Moving to _DSM
would require a new firmware release and force all of them to run a
firmware update.

> 
> ...and for the implementation can you update it to only invoke a _DSM
> and hide the fact that it might be implemented by PRM on the backend?

Additionally, a kernel implementation change is needed including
another test and review cycle. As you described, the implementation on
the BIOS side would probably be a _DSM wrapper in AML added to the
SSDT that calls the actual PRM handler. An alternative is an ACPI
quirk injecting that as AML code, but that makes things worse. IMO,
all this is not worth the effort just to define the interface as _DSM
only, and then use a wrapper to call it. Plus, there will probably be
no platforms that adopt this.

I really would like to see PRM and _DSM coexist in the spec to avoid
all that. We could restrict the PRM GUID to the one currently used to
avoid other PRM handlers coming up (if platforms adopt this at all).
Please consider that.

Thanks,

-Robert
