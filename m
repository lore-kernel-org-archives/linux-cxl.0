Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC843002DF;
	Thu, 29 Jan 2026 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769682078; cv=fail; b=ksdTvKNpnFN+gGdH6nFkarhVyEYg5oZ3wDSVrzAJjElwblFBdiiV2l217OjS7m3YAS8NQmALzmW9gEK1BroxdK6xUD6mOATcryC6/Yq+wE4uuPt5n/Jd1a4ZsDxUp6XL/WKSEwOT+9cu4bC1q96TlalZbY3qLxDmyhB4zQYExwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769682078; c=relaxed/simple;
	bh=ivKTUnf8yIc3nL03Q2vDjWIo0vIpXRULiA8RHYiZgMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jviFH0ZIiQrfz+fiH+rD0HxUc0Nx2p0umVK8s3MKRTgsfCiXlwPhmWUAkZpkEl99WZ8ps/7w9Tj3Q5YHuNdW6HWfn2++htOKGnbH9Qx4NGfpxELc7TV+gtj2rQTkwBjwNwxebwvj2ILermZvziC5UNx+qOnpD7lMqgKP7eYRTHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fWm+zdyF; arc=fail smtp.client-ip=40.93.195.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fWm+zdyF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmqS4/49U9WvFsxN854B/FgJnxs0qHdKA+nhBoKxItlBC9kT85bFMxQ84QxQ7xJMNAwq3Ae30o8/X2ACeLsVIqi2PEFz/Z4NicP0P89YQYIZqz3kk+BnJBpGf+2I4jpDpcaObm8BOJzwHuTVGPe6B9uvTnjEB/gijb8vaOZjOOsOmWr7+bwuTU9iy0nWNNayPlY28SDs+ZfAu+Pbpv57laCK5llDZvQWztmtmtL/HGa3L7jvXvufAAUvuoZxPOkk+fgJIMZQHDEampAD2zlHiEVid+nxr3wEYxH0QpWHVZCXyjCy9no4ta7ZNPUI9tNPl5fj0liVLZ3vhxbfDDLFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1CsvckcJpF3K25EVfiwrp7ST+O2c83o1m3jB/+OnUD0=;
 b=m5w3/fVpaofORutEKB+XiMOsshiATYgkNHFYXzp/AKojWUL0Fpz3IIPxzzTQ3ENGKTAXU5wYJYY/yld9xrDQq+AU+53T6QLVDUacVkqKdZbuLpdJDu3JLleI+Uwl/AGfO5TpEs+CY6gj6qD/h2R7ac/xOvQuWD45tGjLlGdnWYSPSVkNHtaYcyYz7KIp1GciU0RqBy8aNr+PL9kb+QO1Xc22bj5PI5x9N1bXSfQI1ZPTo2weoN/n7GeIgQYQA/OscTcYLJIRZCLu0LOHIEMMREdA8HbHDkZwMweJjPTME8nZ2eQvykezI6+U1h+T8Di6zPo1EFIr55k+a0gpqx/cqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1CsvckcJpF3K25EVfiwrp7ST+O2c83o1m3jB/+OnUD0=;
 b=fWm+zdyFe6zFf4DFFQlbz+aWUS2ImhXAIM/KPx2890fkG4cO4MDvlVL+NUIDmrt8EiE/S3P5cFOj5z3w2BK86fVbDXhb2xPniAfRWGcm0M/5pgcn0jWGChWfmzs9xKipAYpuq3UroGbumoCMmNud/RlJ3aaIelrk5kxuFrKHrko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7)
 by PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 10:21:11 +0000
Received: from IA0PR12MB8746.namprd12.prod.outlook.com
 ([fe80::2915:cc46:57c6:41e2]) by IA0PR12MB8746.namprd12.prod.outlook.com
 ([fe80::2915:cc46:57c6:41e2%5]) with mapi id 15.20.9542.010; Thu, 29 Jan 2026
 10:21:10 +0000
Date: Thu, 29 Jan 2026 11:21:01 +0100
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
Message-ID: <aXs0jW3dK6IwtXwZ@rric.localdomain>
References: <20260122172432.369215-1-rrichter@amd.com>
 <20260122172432.369215-3-rrichter@amd.com>
 <69790b8ff40bd_1d6f100c5@dwillia2-mobl4.notmuch>
 <aXoJPP00R7qblx-o@rric.localdomain>
 <697a6236185dd_3095100d2@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <697a6236185dd_3095100d2@dwillia2-mobl4.notmuch>
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
X-MS-TrafficTypeDiagnostic: IA0PR12MB8746:EE_|PH7PR12MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: d505b2d2-be03-4a8b-fe62-08de5f201ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ELvDuJ86uJblIafSy4h/qu3lt4UaRwfY5GGUaQ3+mi/c+nXQVfaL9q4ideYa?=
 =?us-ascii?Q?Kn4nQn4I9LmTyA6nTf5NjDblNr17ZiJojCnTHzEP3VGTnUIcQTHH53tZXwQa?=
 =?us-ascii?Q?yAM3AsMenZKLqydqyR1WwCwzLmn7USNbGRK9Ys7tD7tSlKPQABIj1lxmwzYw?=
 =?us-ascii?Q?q+CnWAiJnlsmLFqXQFDc08pj1Pry3NvoR/NdOYW+kN1DV7Tlt2AfP5GJOKTy?=
 =?us-ascii?Q?xD1VTWh9aWbIuPrX1mMY9p8FhSb6IIERYiSpjltqngoGEY3kvYVswlZb9etc?=
 =?us-ascii?Q?M4psq83cWiI11G0E6LVkfjx4CrUcP00MLRy3mSSIbEwz0LaJ2LeMsDUNEkj+?=
 =?us-ascii?Q?9fUS+J7+KV9CslGJgW7TIFPonC9QohF5rFCUpjKZ7xQPNXeeotKD4hCoU6mN?=
 =?us-ascii?Q?NIV9zVLU3Bn6L1d60UqjdSy9WJAsIxpovfWWvjt9h833Q4wZt281xjSMroJt?=
 =?us-ascii?Q?zYLNWotheRFw6CfNYsedS9scIob+Z2YOasIxCJe+ETIPDa8F2Og71QJSw2PZ?=
 =?us-ascii?Q?Et6hh27JCpVVdmG7XNQzTSr27eRPhRtEOp8u9kLm7zdPuMOrGCMen7ZT+BSD?=
 =?us-ascii?Q?P5uZ48IaaPbgYluc7LU3XQrocLYZU5947Bt/pJqASntY2GraeFubO9sAgd5O?=
 =?us-ascii?Q?ef5rMzrpr0lEL2Fgo9BVdwdEWgZM1EIMJkUmkRhckLYhsTbJj9eUfKVbf/fS?=
 =?us-ascii?Q?NmXHR7UMSJ64mXuZbrNKxv7eEGomfb6KvmR4p30PkryyF67eOmIu3UCT3ThO?=
 =?us-ascii?Q?Gc3LSx/C1m2mp5O6nkWDfK9jGWSjEKbgieDqk3SsGMH+Qm5icvY6zrOli1gB?=
 =?us-ascii?Q?hRzlVyMk4mffvjF7s6lNzHbniRfhxMg5ZOsCqUYEDw/UBRz2p08ik471WSMR?=
 =?us-ascii?Q?aNeBP73ijWmN4YYXs4VA1poibgfG26Vf1HlPukIU7CMwL5MXZmCLlfumEcGY?=
 =?us-ascii?Q?+dVANlZ1nivejQ6mioZWy4DC1ehvt2jEPuvSqTCX2iUJfSmIVrUF+M+GDctD?=
 =?us-ascii?Q?Uhpm37SVRl/QJCeR0zrt6KgbdhsieGnY8AXCAe1z19JYcZOuitVg6GJyb4l+?=
 =?us-ascii?Q?dlMZp2auOlTIqZGMSU0t39hEfQ9OhIntXim8s/gQ0PmFuq6Nr1+qO5XhoNY/?=
 =?us-ascii?Q?JngoJv+Ui5XDnUidO5A5TYf5ogAJHzOAvNSm05v5fhSxBAlRxyNHrXAEtq59?=
 =?us-ascii?Q?5ABIsjaz4SHmyXRnWAu/aIrTASnkbY2t8KDcO3JZtbBLO74h2rxs349MqKQt?=
 =?us-ascii?Q?IT3s4SzJLtTVzH+jBZWpuu0f0e4OhFihKmoItsxDPLoU+1e5emM6ZLs+Islw?=
 =?us-ascii?Q?RH5EMBteMuP2dCCZ/pxwiD6FU4eNOQuLmicHPVFoHAtTMoYc5By79PdZBAyr?=
 =?us-ascii?Q?nUSEkvLi6ZnEtQ1vKibDK9KLrrJ0o1TCYDGhcZx6KaHpSKzDltWx5pP0M+Sn?=
 =?us-ascii?Q?RxRwFNxC4XAbiiQBF16NldEezb8IXtwiRGLrdvJXM5Y4n9Fpjph1Bwx1wljY?=
 =?us-ascii?Q?ZeK6GbW6/BHp+tjjQ5674xYU+2C/Q2kDAWgmMDY++vChAAAXLLIpYVSx52mD?=
 =?us-ascii?Q?wims8eHgNsJJHXmW1mI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8746.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5b2iNDeyb2toejQQdvYanC5rfqvPbY7Uohj9VeY/t+1yEWhq9hPQfdf+9L/t?=
 =?us-ascii?Q?6wfL17ouSLdf6vOh/CC/5F8xblU9yHyytkGeVa/iW+Ir/q5WrdwjgsLnMTpO?=
 =?us-ascii?Q?QssF4IJwRqrtwyYx7pXWcK1hVVPjB4S5HUdAiMV3+QAuN4z0vuN8b7+SHMlE?=
 =?us-ascii?Q?1mdaavmjEvOgf3JkCIHrTYoPg8WQlnNPBtd0fSedW/YTN8QXUlCBeOi8UYqt?=
 =?us-ascii?Q?/vXm7Ikpagi45fhxXkmTsXU9oLu4snhqsVueBaTA0mPik8c/poxgGliMn3Ro?=
 =?us-ascii?Q?rrzWq0Gcpf2dZDnUf9dGYxC4u4O6pP2aSttTudvSeUH2Y6NFWblUmBB0kFcb?=
 =?us-ascii?Q?kobL6+gNEsAIeG5JishEmWxm2URAGonakX2Y+U0AoE7jWnx3Xv/k9Vxc3x3Z?=
 =?us-ascii?Q?TApApHlWGY/vGURdk6MwBPcQvfVOcwCnCC5dwb3tTz0TzsOre3ZKRRDJDOQc?=
 =?us-ascii?Q?E8nj6NSLpmgaNkg0eegncW2qZLdLG0cBpjj/MRXhJoLG+Ms3leA45+mirxCh?=
 =?us-ascii?Q?laXS8MbQON0AiHBugcgMW6NVaZLOmp+Zl8HyXWJTcBq1JHXf4rhV7ruRQysC?=
 =?us-ascii?Q?L/vmgnLTkIKY1r39iJ2/w/hE+0L4nVXaBvdH2EYTXOYUz7SCCmPzN/uCkdcA?=
 =?us-ascii?Q?uqp4gypys9krIRey/RPLooIIw3Osv1O0k6gr3yVKUAXHmqMAB/B6qzRdF45C?=
 =?us-ascii?Q?9oqb1uceUoh8JpM7gWPc1qWgGTo59EBztTtGXXf5FPFwHX6CHKzkZ5eKY1GL?=
 =?us-ascii?Q?OW1JofJvNh8gKsILf5OJa2kHbmGmwGGRRgfquFfAyqUqxycSOcRa1jGaKQJJ?=
 =?us-ascii?Q?jZadrr/CirjzJ8vNImzkz4iGAQYa2PIoHFTC9yAZrwSiBFEqtbKYVbW6thUV?=
 =?us-ascii?Q?IJgcTKVNZp4L+OCyldlMRjK2Z9IjvpReqdjbRQMPaygx9NRW7CuHH7HuLrq6?=
 =?us-ascii?Q?6K1Qv11D45Fcq2BqTOKHgnVN4AuS1U+huYT4p3LeXuO4stG/zVseUBPSeV94?=
 =?us-ascii?Q?r968wLDl7zntS1Rn2yB3LZ2oa1JywIICeYsbWpEGaqPIuqMVPIqkXrmHtTWA?=
 =?us-ascii?Q?hmttThl7M9+omGwxjUb7eOJ7igOTw9R8+/W+V7AvfYWiNpfTnrFrWTsi4PNQ?=
 =?us-ascii?Q?y0Hi33Enpd6XLQ2QlIHeHhwpGT2mNTNb+06Yq3qUuHaBPwlh4Fd72vrZ7FMx?=
 =?us-ascii?Q?TQjEv3H6RRCJ6mfbanTFprLGmhRH9YWxw4HZ5KSIGPPWAoCfPVvAZu3er2Re?=
 =?us-ascii?Q?C2peEYLfISoqwgqHyKyq+p60+z3Fc8BuFb1W8orrt3+Rtf7U4wzR53Gumfyv?=
 =?us-ascii?Q?X8ivaejtWXnMZoNZGsjm+sTEO27CaSWRD+38KhcGMyG4eyM3p2HHZ6Pfwh0k?=
 =?us-ascii?Q?VOEwji7hC6B76Irw08MKefQ2NMCy+I49JEOBic9V1Bz7l+xHAqqNm5077Mj3?=
 =?us-ascii?Q?NTqN//q2NLlyO2ZCqvw8MC50t678QYmLiOlaYkynYuGMFNmuc8JWMbIhLK+Q?=
 =?us-ascii?Q?yBAkbl8NCNrdSG+fVEj4wkcmJ3oStGb8gZbm6EFFFN8mtjq1sOJEW7QmcOtO?=
 =?us-ascii?Q?bWO0LXt+AERNqzGLRYkAxUxO/r3x02J23MkfcTMUlmgq/8Ks0egdtmHjOduH?=
 =?us-ascii?Q?bdD+WuKisjOmNNp28xhIbkm2ItbnwCWDHU3iP5kOhdaQU+pmGyUVrdUneXgo?=
 =?us-ascii?Q?s0TOepE6G3ywW/i6qxfnIIo7tHicE8+STI99aiDSEo4CtUjyT1dWQoJb7Zjk?=
 =?us-ascii?Q?z7liWQwdng=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d505b2d2-be03-4a8b-fe62-08de5f201ddc
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 10:21:10.1333
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3gN2JkO2IMAPO6E1XMXnsZvwVnF6vCqXwhhp8u7TKjgO/SVO6f16fa7bH/EulQ16Xm4d1fDvnF8IqZyleLQQuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106

On 28.01.26 11:23:34, dan.j.williams@intel.com wrote:
> Robert Richter wrote:
> [..]
> > the Zen5 machines only use the PRM method as described. They have been
> > out for more than a year now with stable firmware. Moving to _DSM
> > would require a new firmware release and force all of them to run a
> > firmware update.
> 
> Ok, so then do not document _DSM as an option in the convention
> document. Only document what has been shipped and require anything that
> follows to not deviate from that de facto "standard".

Ok, thanks, will update the documentation.

> 
> I was confused by this convention document offering optionality (direct
> PRM or _DSM) and then requiring that the kernel accommodate the less
> preferred option (direct PRM). If there are no plans for the only
> existing implementation in the ecosystem to support _DSM then simply
> require direct PRM forevermore.

Oh, I thought you were aware of the existing PRM implementation and
then wanted me to specify _DSM in the spec, so I started with that.

> 
> > > ...and for the implementation can you update it to only invoke a _DSM
> > > and hide the fact that it might be implemented by PRM on the backend?
> > 
> > Additionally, a kernel implementation change is needed including
> > another test and review cycle. As you described, the implementation on
> > the BIOS side would probably be a _DSM wrapper in AML added to the
> > SSDT that calls the actual PRM handler. An alternative is an ACPI
> > quirk injecting that as AML code, but that makes things worse. IMO,
> > all this is not worth the effort just to define the interface as _DSM
> > only, and then use a wrapper to call it. Plus, there will probably be
> > no platforms that adopt this.
> > 
> > I really would like to see PRM and _DSM coexist in the spec to avoid
> > all that. We could restrict the PRM GUID to the one currently used to
> > avoid other PRM handlers coming up (if platforms adopt this at all).
> > Please consider that.
> 
> No, please no coexistence of alternatives. Direct PRM is shipping, catch
> Linux up with this singular reality, close the door on future changes in
> this space.

Understood.

> 
> If there is ever a "next time" for a different platform concept,
> strongly prefer a static table + native driver enabling approach.

The translation algorithms are not trivial, see around AMD_ATL and in
drivers/ras/amd/atl/. For CXL, PCIe comes into play in addition to
handle that.

Anyway, thanks for your quick response. Will send a v5.

-Robert
