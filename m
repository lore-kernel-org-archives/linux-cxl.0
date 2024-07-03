Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1653C181CE2;
	Wed,  3 Jul 2024 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720022855; cv=fail; b=fzOJjgk842q/0WX7ReJkO1EGZzL4XWvvIvr5ZxK0K3ILO3dM5fJ2rRNPxnh9bjEv0tHVAJPnqaUVFiyALFsk+g0TY3EzHBCtK3Uphn4IcGTBV7mxYm8YK1OSxQ7YRixshfutQW7wOVJkw0jd4lF9i/3bDT0MRfZhhxmB+M3bE/g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720022855; c=relaxed/simple;
	bh=31oqUnrXaMiLHIqPyI6zF+FPuUqKbOUSFZn7JpC4CzI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O5/Wx+/8wDVTjQwLaZUR5IPOXu+/sspLUU7pQqovtNJ/rmkluLTt4XYG+WVlHlxAoaEOS2u74yvMWLr8CGktuLHeNjOHi6bzX7uwaYrM64nijybUFx/W9PxfKWVYBOEOKOu6zVgxzXlLNTsD4wAHQfsvY/R8i3b2/OHn/QgFSQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BD/2KIwH; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BD/2KIwH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720022854; x=1751558854;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=31oqUnrXaMiLHIqPyI6zF+FPuUqKbOUSFZn7JpC4CzI=;
  b=BD/2KIwHsnWn7oHSL2kVAibjvzpes2Znaq+IGUkLETPDl/hPIRI2vsjO
   hygfu/KUe8SvJ0tpfwPVQ9qvZDiBVn/RJ0VviIpe91lPampGoV0xuz8+8
   Ju/WIR3Cx94NJ3Io4mX8nKo10sJYasgZUf+wdVGGwMBvEViJL89ui/vOv
   CblsOVcqHaDkbRC/mbRBmLEWBuFw03KaZvtSYXX+nlDHS/R3JMKWGE6qW
   oqsoGsv02KgzsMEa1f7z8/62ozP6RScNmO2tDypZ1PQJyrpWz05NCFpTH
   J0pEKLd+MKSTgQYVyjhiPgaarg/lrTfkyBP18ABILzau0BY9D6hWqruPj
   A==;
X-CSE-ConnectionGUID: XTjkHvGiRtC/cK5vsNSRMA==
X-CSE-MsgGUID: YY6IGPGyRSGWeKmbHjfmRw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="12378952"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="12378952"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 09:07:33 -0700
X-CSE-ConnectionGUID: grNrn9GgSnioo9L5Y89OmQ==
X-CSE-MsgGUID: LIdt6DzBR0a7NwC9slA4xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46442813"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 09:07:33 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 09:07:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 09:07:31 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 09:07:31 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 09:07:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/K4pq+LYwTUk6qXL3aWncBnWuBsSGjwlL/0ls96wuWipD5KrjER3ksXrrwhxGvrP6OS9OInwGEL0CcAZarVVllB+NdEoXF+HX0oUlj/M+EOgIfa+W6+dX8wwyZAYOWlON/5mKMI9a4XuUh8Fp44zI3Amlrz9zNzzlfoN9l5XM28YyaMHtt1WXcctOdmUgKVJ2ravbXw+IUiH1RoACpELc9XEf1fE7mYO9v7xPqAPF8W5vLScdhlG98jw+l7JxZhM2P6QwR3lAejBYy01hoQk5ukyIv7lll0eE5+P2kArFQd9iw9p3fP/X2f6VtXpwhmV2vJODNuaL3x1EX9sSxWBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31oqUnrXaMiLHIqPyI6zF+FPuUqKbOUSFZn7JpC4CzI=;
 b=gRnBmJHIo+0QvbAI6h68lSVOX/ypmKW2EVvXirskXCwTmDEFIpzYjfQ4Pt1RaNflmdIF8ZiBTNA17Z8XtX97gPu2ZsbX5rVqrKfHLRx9i+vpL5AStcXjesMRuPk7TOy7itEyiWnvaqZUuyUb5P52d2K7tagAkVoZiUIdbF9SuNVrU6X59az9wLScuAAXMVAp4+m8VT5369TOtITM0BZOTZ+1xD+m5lbWZTWIGUiX2oR9Yaw86GxLqbNfKta4clwWSKolMfMqaJ+v1vAxwJxZGgxLDIEFmgq0y59YQglOgV3mU8QrJCzIWMuX8RhZtDu6yFKY+eQGqh2vxlLTM7QWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB6356.namprd11.prod.outlook.com (2603:10b6:510:1fc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Wed, 3 Jul
 2024 16:07:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.7719.022; Wed, 3 Jul 2024
 16:07:22 +0000
Date: Wed, 3 Jul 2024 09:07:19 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] cxl/acpi: simplify returning pointer without cleanup
Message-ID: <668577378cd31_4fe7f29441@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240703083055.95864-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240703083055.95864-1-krzysztof.kozlowski@linaro.org>
X-ClientProxiedBy: MW3PR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:303:2b::24) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB6356:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bf55896-ddaf-4b5a-d312-08dc9b7a38f7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3HjzMHgcYHMuOdY9mM62TLUF9WZQxRqDFq3pAy54WM+B4lgD6yLHWJ8ENTl0?=
 =?us-ascii?Q?hotx5fm/I+WKQ/0EwvIqaCP2Fm6zR0kTduqoRNeF9ephzrhRdFPS75jbhsTA?=
 =?us-ascii?Q?O23SmzwdAz0A+R9Apu4hSdtoPI25sW6d3bvj2nZWg3MM/Cr7/21UFDcQ81sh?=
 =?us-ascii?Q?ZByuOY5ND+iZ3792xHxGaCcsRlyuDYkWu7IYvBkkuTuv+ogvkii5DUjmlfEX?=
 =?us-ascii?Q?yTzmS343S8GwqoJd5KJrkQeArGyzgxoPKH4s4Pn+eGbKatSGkI/IqRvnIrAP?=
 =?us-ascii?Q?pPM8xJyB31IQqdIYHkOXkyDIhc3mDIy/MFfkINE2YFWVYz1h5jJhu7cKruyY?=
 =?us-ascii?Q?uVUdE1QFA1lZGpK5wN3CxtF32nGaP7teU26i2Xv1C33/v0cDnjQBsHBXYebB?=
 =?us-ascii?Q?7IMwV8BxIiV7/kg6BAOWm2Kxb/TBH0Rvno2x92DA22dl0aYxJciR/eoM3e2J?=
 =?us-ascii?Q?3BTruugWeI2C1KWhhQQ7m81AavQUL80CA97MN7JEc4aDx3qMtGaTDynCEjMq?=
 =?us-ascii?Q?fHVdNmZn0MXHDtFLBMLPG98Ty/Hw8vudJXOFRthc2UeVdNUR9gIUn7K2NBii?=
 =?us-ascii?Q?357nvLzkq3YZnO7bYKgizMpFBUWl6ZnGY+LKVuPP6sTKzyHs3V5NyVPfm5Df?=
 =?us-ascii?Q?fxTpyBq0v5t2NAwvbKMqTf7JQ6lb8XcBt0WU0Zb8saba2+EElXHjWpsgOjyF?=
 =?us-ascii?Q?tSHVzqFTRgY8Zeio+Zv8nOsbomPPqrpj3opc4wFH1MBTWavtaO1aKNFQQqVo?=
 =?us-ascii?Q?VsXnkdFLIGzEGglSWxpHsYMJmkbJv1JCemLrN5ilyB97OYVGvzCMoumIFnH/?=
 =?us-ascii?Q?EBORPupWp3KOShjW5Bj4eYz6LMabrB5dmR5nPWbUmt0C7arPlI8ATK4kPHi9?=
 =?us-ascii?Q?p7eyRj6wi6kLYDU7uMIPwa1YauXsPREOoFxESo4tLX8SFoLklLBiQk/Bv/Lb?=
 =?us-ascii?Q?x4GRSHrqPJikX3fBsExnpkYMbEVUAbWQHgx76xkbdOHaY/6Gbc119oiVRO8n?=
 =?us-ascii?Q?YoILYVtSWadOpUNBVYgus1M94XCoYEWHXxFhk8rWpa91Ul8mryiCEufHNOkf?=
 =?us-ascii?Q?0EikWtzb49hvVbF2uXw+XGTNM35HKr+HSL0VCCqHoRcVYKp6tM8hK7Lxu5m+?=
 =?us-ascii?Q?qg5lXrBSx8JPJlBaBNyG6bUGFyD2sTwwvW8ATC9fdJ//WMjX24yXh92zGOQr?=
 =?us-ascii?Q?y7AW01ACjfGCDqDB/GgnUaqz3ewG/G8NThkDdhrvw4v7W3rlS4zrg0dND9I3?=
 =?us-ascii?Q?Kycq+bkvSh8XCbqe0wkffBhbiXIJIGdCRKnDKvdUvr4IABmuhMysO76105dU?=
 =?us-ascii?Q?hZ1GtbqIoUJEtLuD1NJNATb4ezEp6yOJ3KWhZjDYRiq3HOgC8EvBrMpnOIKg?=
 =?us-ascii?Q?qLJYVZosRVxs5BIgrPqlxKlpBuI6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cvnZUc9FUnj6TOUiiSyiHneVsrV0I9qE6gf6bD2hSlWyU46zi+WhH6/6Wlfi?=
 =?us-ascii?Q?ImRSkEhNTA2cM1JpqAT8rLVR7ADZwXaJlwlRPUQe52LBnCJaW0gQe94voiK9?=
 =?us-ascii?Q?hanyR0tOE8YCljcXaR0ZhIncoByBEVW+v+nsVjsl4U+VycVn2lb7KzY/igDc?=
 =?us-ascii?Q?WA5TqyzabGWerZdwZHeGflgts+/idj6q9/Qp8kd76vUqcODWe/x7vaAMLg7Z?=
 =?us-ascii?Q?hN2D57XJ+oIpvc0SmfRJXTV+Tu1GVrqaUm/wQoNfwgitpc/4f/dZLk8/XXzs?=
 =?us-ascii?Q?DM9B5OAJo3RhjL/nnPceyhHGWfF88ZDjDM3XvsXqdyZupwKMwd4kqE2UCeKL?=
 =?us-ascii?Q?lWiJC3x3+K8S9OeoI8LegAaT4AjmgU3Hg3LtsEpAHHxO9SHgw101YRvb9+aX?=
 =?us-ascii?Q?jRZDqt+jDY59GO5gu0+Yd1TQP7yqreKMRP2ikLDtL1Joy/v7y4jHVkwZFO0j?=
 =?us-ascii?Q?7jVtTAHzlY2Qcpp74GTFbfrqfn+2s2UnKbGn5/WdqSNr4BmKVE0tKKm4MC54?=
 =?us-ascii?Q?1GP81hEPPVJkjSYFV5cYLx1MpGZ2QLilxmjQWfyVG3Tn8PBmvRRRE0yNS9QN?=
 =?us-ascii?Q?Ca9FISXMOfylhURxqDXQBc1q9xGF8vuQtOkCk8NaezMSL535pi5itFkFrIuS?=
 =?us-ascii?Q?Vnck5xiowi8nCJS9Ab3PSt/tskiQ99Igk/873Q1ksGWJXYJ1Kkkhf4mb/koz?=
 =?us-ascii?Q?+m8Cdwqk/kTMZ4Xlp/N+7oXnwKBSUyS1IiEIqaqJIl8jgnPYeB0WsUBsJknP?=
 =?us-ascii?Q?UZgqsEFbMfnvET9W/P7tWnJvMMia3LqPtzI1Zeaf8htvu4qNJ3h/x3MMzcjv?=
 =?us-ascii?Q?c5HipQGc8IbNX2kKRgOhAyjcA95lxqPLmF2b6t35cO8cAPib/FIQ7HC+VwmX?=
 =?us-ascii?Q?O4JVp2ny4B5jmcRvc6SbTqr0M46uj6fkP7i1Nvf88R1bMjAXrm9R4o1w8dCS?=
 =?us-ascii?Q?xMtmHLH7n6Kc7Y42IDVBNA4ZoAVUkZZFV/5lAtz6wSv/E1qFxnQbYW3goomK?=
 =?us-ascii?Q?V835BpdMWmOphVrs+pOn5QSvInK9xylK4pkl17isV3T30a6PiZunz5belPWf?=
 =?us-ascii?Q?wXK8nsJjhrTwhgnp2XLPJ3/n7kjnlOS7f4qIo5O/KMXuQ4elmo+EB6wcpFvN?=
 =?us-ascii?Q?swyaThL3Dlbk7alc2zT00mzzx5fcnGJp/nYjaMldUR9r0iQdBwmh5cQQJi5L?=
 =?us-ascii?Q?VLfFU/J/jVLDYfEeoMj6ZmwgQvlaVpi+Vgb4nMNtOoKP8t2mtz6pG2mPvLxK?=
 =?us-ascii?Q?JuNnUXnGXA7a32OaRCUyoRSu3WMXuVxwL6/yUO4FXvOpi77LCUo2MCsujEh8?=
 =?us-ascii?Q?gVArzTpMlfPM5N37Plk5KbgzJQn1a6WVd4gkvCaNtst7VhhdXSIKYQe2My4h?=
 =?us-ascii?Q?39YRO4PxuVoUf+ypts3tTemm9PXlyOON9VBQ4MJj4cL1zq/NjaCevpBrogl4?=
 =?us-ascii?Q?JAI6dnjNrtu06jkLwXT2Xe0r/iFjCUet3z3qGrdXjba+FXwpXuCY1r20yYHO?=
 =?us-ascii?Q?gVYbx2gM0BDesGd27biWGwGyiewMebqm/JSWJYbXV3DKxw3CZbkfcvlCQQOZ?=
 =?us-ascii?Q?D+JLxFkGuy1ceMdm5kQdIGFff/WGd+yHUVE5487pQoW5iwQzI77L8xkdPLnu?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf55896-ddaf-4b5a-d312-08dc9b7a38f7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 16:07:22.5945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ddMnaypC+Cr72wJsl32uFX80Z5CPhltFmd3hHdNaMJ2/2fJXV3SVsCZ8bVO56QFrYu1fC3QiwizWwu26GwMDIcxxcEN7C7rj1L0sEwAJ13U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6356
X-OriginatorOrg: intel.com

Krzysztof Kozlowski wrote:
> Use 'return_ptr' helper for returning a pointer without cleanup for
> shorter code.

No, thank you. For CXL, I am not a fan of macros with hidden 'return'
statements.
