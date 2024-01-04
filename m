Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06161A29
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 01:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nklVpX6X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704330064; x=1735866064;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jdmCZhldSB/1VgOZGkW8KaKfCvPNj0C9WLLWQv1ZT2A=;
  b=nklVpX6XGq+jwlk5iooe2ZYG/wtCYq3mV/q4JXdQ3XyGcDdiD4cb2Wvi
   wUn5vwcHHd9pEoAp5bZxiCnUTDGQcFk8h9xaqHKfu4DRZVEvyQ0ToQTmA
   aAfTxb8w/dOj66AZpwLjqQx3M1aPQsXK5qXr4CzgrWd06NA3gqFo05AeC
   dN0NbTmiQRlpls3lC4V40J4SJEIl3zKHUbzXaSv2fpRnMFFZ+mflmd66t
   sFRBnW5TwW3lxvuiVi0qAQ6NZ0hm+PJNthjnFbGlDgnCQB9wqX93UxVAa
   ZQ7J3kEGGeW3TasIKmTwltKHaAHHktSmDADN79ZcYZpDYv31QqptqkBUX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="376587688"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="376587688"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jan 2024 17:00:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10942"; a="1027234573"
X-IronPort-AV: E=Sophos;i="6.04,329,1695711600"; 
   d="scan'208";a="1027234573"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jan 2024 17:00:58 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Jan 2024 17:00:58 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Jan 2024 17:00:58 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Jan 2024 17:00:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrWnkOmfdb5UVOKsG7czHLO9rfmp/J9eJzmIwcKBQmRhY0Gvu7bQ9EY5E5z1IHpGzJIikcNK8fsKOybRKQZeIu+ziyl8trmbbHxUXsqmvh/F6pVdPpZiLixHxkr9FvmkPOHfUig5j6kuOtcCmls5BL6xC2S4GvLetrHnfcFOK57yx+eoOB1friQaIt0QAKYLORsxOwp6ntvfZ1vecx9LVy47sSfgRlY3l985qKbpaCkFvIH6N546h2WMtd61ZrWz/nKhnfPhix4K478EYlezb41QYv3ifsfHEWagLdkJL1jT17K/RbB4HirlCn0nbYdQ1y5fPvqoPK/KCP6Fddbicw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6f7+CEbD+mvA05CyIl2788SHHGTqI3zU9/cLudC5YZw=;
 b=XMF9qA/hLfq8R7e33hIwXF/zhNXomtwKyBCll3Rvfs+AnAY9WLWeI174AmuYnvmnnGDblClBV6FS/0EG9qWURjXj38+tAKRuBzlLvtoHhR+McIEyxPc74L2SuIWgF50rt3nxzV2B8ObMrxdu2Jh3ctbSWxyeVq2atu/WUyTnERtw8qPe7RfamNjtGGFPbs7ipGYGqU8Cv+1GXwg2XN8z/dKFlGhdkC1UNBXXMpoNloZtaKrRbxJK2+TrkGSpt674/zuH+s51eU/mQI6a7Fz6KHswdbSx1ZAZCifI6OI24KmVwYly2zB9G4qxDv0ixArYutk2hA/eZHEzAXftytQkMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH0PR11MB5348.namprd11.prod.outlook.com (2603:10b6:610:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 01:00:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Thu, 4 Jan 2024
 01:00:54 +0000
Date: Wed, 3 Jan 2024 17:00:51 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Dave Jiang <dave.jiang@intel.com>
CC: <linux-cxl@vger.kernel.org>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Len Brown <lenb@kernel.org>, Dan Williams <dan.j.williams@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
	<alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v15 00/19] cxl: Add support for QTG ID retrieval for CXL
 subsystem
Message-ID: <659603435f569_be7022944f@dwillia2-xfh.jf.intel.com.notmuch>
References: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
 <20231229000414.GA1559983@bhelgaas>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231229000414.GA1559983@bhelgaas>
X-ClientProxiedBy: MW4PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:303:16d::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH0PR11MB5348:EE_
X-MS-Office365-Filtering-Correlation-Id: b3fb6b51-2146-4bc0-09c1-08dc0cc09a26
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fx7Gkdmktrv15MmZmbLFfDS9Xfj+M+f890yUvJs9ajvulQZreKw0ZL7NT8Yi0tIyZC2YW3tLpJW8Zf/UCGDbT8Zl/8tC0ZNYSh/vgxsnHCJ0HdPKdR1KuCECywoSjQqrAB05VVMJH+or0OrbrvxSJN7F2m3L1UHzv3Slbk7p5PUjGeOSDgleqtd2KpKAjyOk7trDvgoJlez+LEVstyawzuGkrK6KdOeWvHhbNbmra0qpCX93ZigVQZt3WhXdtLWHVlDNKzJt4Y6+9CbSXggpqU4OgroSQvYTiRJxOyI8OUH5jJz8CWV5KJlY4zVqtwx3vNVKKuu6zq1EaGchU/REHpsz/WLW9TmqnKREiVaFuR4UQu2LHKZz+dbmAXked4uasOHTlhPCQUmz9nGts4hQJMUYAJmCQUmlSpbIWqiM9V5Frg07nH3xopaW/GDRhqErwveT/AI32esniZMswCZ813ry6UZPbG3InE+ZPILgCyW8fp7payfBsiiRAhXnE64r/X/E+WJEMJwegQSLyt9MGm0zO2GULql91IN/6gRpbop9af9TXQ9B6Smchr0lPphp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(66946007)(66476007)(66556008)(83380400001)(6636002)(82960400001)(478600001)(6486002)(26005)(4326008)(110136005)(316002)(54906003)(6666004)(9686003)(6506007)(41300700001)(6512007)(8936002)(8676002)(86362001)(5660300002)(2906002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0dh+T9kPWzJDg7uMHBxVfWhNIxC9TMWfR29p5JG0nU1/sVa/OFVe/nYX5IdK?=
 =?us-ascii?Q?3XK8Sjb4LGyDo2EyQ+BxQD8qZCjtGjY3BCktxgsErUiByIfhhcZ4l875dyku?=
 =?us-ascii?Q?mXXg8XtUscxukWCJ/tFFTFUT3o4VD9dLJJpodbVq0n9aYB1D4r2rC0NS0yDJ?=
 =?us-ascii?Q?gcN1S1lDUKxjoRyopU4qTMnz4nv1rp2ACBnVVFz1CwZIYrM/5rdvKnU2Z44t?=
 =?us-ascii?Q?TAUhpINXtApMfxZuHglqPWlDPutlCe304BVWnJ5OHXyoBrbtx1DYUKFfTy+b?=
 =?us-ascii?Q?lJvsHP7PkSUWLMlxjo1pDFnshamD2OVxfrOmbdj9wQmaTQ+YEFD/209t3ZgJ?=
 =?us-ascii?Q?kcBGsql8+1mRtpVxGbT7jWLpvNil+6jOrx3aaJkFEe8W3DWivMILdvuWGxcA?=
 =?us-ascii?Q?2Q+7J08Jz8J5hfXRvT9R9c15bnY7zXL5u1z20B4IslwE1dj62c97jJjVBnAa?=
 =?us-ascii?Q?vLR+HOo29OWFCFJgZk67NYyFZ32Uz/0OHAOyZLsd9RH22ZXdZ++KA1qxEIGG?=
 =?us-ascii?Q?R/GEGnqbU3N3lQG8kHbPXKkKL0Vv6VBiuTkq5utKruAq6wFHbJ46gfYVroEC?=
 =?us-ascii?Q?jgQru86wAxBV0V533FCXWcnn0hHxM+AwDZAVGMT/nJfNiNaBfc4WVcw4eOjj?=
 =?us-ascii?Q?xJGQ8zl8MUHwekDjJtfb8QQHlqXYE+QaQu7/b3NKuCW+gyKd68blCCPDwLHf?=
 =?us-ascii?Q?5gAqsHeGcT77jKp7kT+C2v0+l/723D29KHCUlaUPjND0du9bStUWjoDvn7b0?=
 =?us-ascii?Q?POx4x87ROYJEAOBHlc0C4wVQfBmjPlSNlXVVnOWpfOHRl8PYuRWPH8MGL7nD?=
 =?us-ascii?Q?LNAN5rjR0dR1hl3cwqUD8w/Xx8WJovkdfcJS/uZfSkwBBccrNrckUHqdLmpP?=
 =?us-ascii?Q?aqaay0F7CXbiMBrkhZt1SXDH1OjX+iKckLnEWohZas0o8u8X+Q0VKJWfMzuq?=
 =?us-ascii?Q?VM++PK7jN/Mg+BcwrfH2Hy50uQfzLShWE4frcgU+6PWqtsUhx3aqwgN/06L9?=
 =?us-ascii?Q?5l+ZfkfaWKeOnTzhM8iKDiOlMNSYPKcbYP+F2vWVWnuh1j5MS1qJ7n05ZR11?=
 =?us-ascii?Q?/yxDL971dYUYrWjc6/6jXV6+cbAJXq+9KD7mSgafU+HrrDXjM+S1PpKx9Ewi?=
 =?us-ascii?Q?AlOyXeAc5gdVNbX42lYMAyHA8HB8c715Jb6aAQnjVJB/gBwOTONhQFV2DxmY?=
 =?us-ascii?Q?me7n+uo2LnpmMJ06B81g/zBZjHpMrtMJsEul3R1OvMVIwmLKIGAfdUOxMQ5G?=
 =?us-ascii?Q?TAGwewICBaGvHP0Xcb+dhmV61w2AZ8ZZLVQA5WRtudU4DDrv70wl90E2HC6g?=
 =?us-ascii?Q?h9rkKh7FBbFdSGFSlBFLevW9CLeru48G7yOFigYLyvJdoEOeTTlyCgl6lfkn?=
 =?us-ascii?Q?F/0WTO641hDCLN/C7aT/Nfdd9Uf4Aw6qpPJ7m2kpMuOPIvLceJNAM7Z/JxDM?=
 =?us-ascii?Q?H+0mmxQMXHN1yrI1ZSAc5OwYFrh2B3YFcaibWlTOIo/bFRoC4xdLsY6XKgxG?=
 =?us-ascii?Q?Z6jyVffHUrSkTF3dpdNqy537btC+0os8qTW7DFwq8xMcUfE/BIpCttzwss6C?=
 =?us-ascii?Q?AaIeihS4jdB5XBI49Yq/7A9Yuh8ol1OboOSFcqlI9dKBDczUysUVP6wLJk4b?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3fb6b51-2146-4bc0-09c1-08dc0cc09a26
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 01:00:54.0923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mZe2/qF5NkEAUlfg/V3irn90MlCKKem5yZ3XGSpENeXNn1Y4CfaIOIT2d8aGcBvMmRovAlsz1G/MKPcwS3B0groPBZ2VSFNFEq36oLmxPcg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5348
X-OriginatorOrg: intel.com

Bjorn Helgaas wrote:
> On Thu, Dec 21, 2023 at 03:02:25PM -0700, Dave Jiang wrote:
> > v15:
> > - Update the hmat generic targets via hmat_update_target_attrs() to retain the best
> >   performance numbers from HMAT table.
> > - Refactor qos_class valid checks to simplify (Jonathan)
> 
> One of these versions apparently rebased to v6.7-rc5.
> 
> > v14:
> > - Fix 0day issue with fw_table usage (Dan)
> > - Move all DSMAS processing local to core/cdat.c (Dan)
> > - Change get_qos_class() to qos_class() (Dan)
> > - Fix perf entry allocation lifetime (Dan)
> > - Rename perf_prop_entry to cxl_dpa_perf (Dan)
> > - Cleanup gotos using DEFINE_FREE() (Dan)
> > - Move qos computation before regions arrive. (Dan)
> > - Drop unmatched perf list (Dan)
> > - Add target_lock locking for retrieving genport coordinates (Dan)
> > 
> > v13:
> > - Convert temp dsmas list to xarray, optimize DSLBIS matching (Dan)
> > - Add a cxl_test fix for mock ACPI cxl host bridge UID.
> > 
> > v12:
> > - Tested on hardware
> > - Rebased to v6.7-rc1
> > ...
> 
> >       lib/firmware_table: tables: Add CDAT table parsing support
> >       base/node / acpi: Change 'node_hmem_attrs' to 'access_coordinates'
> >       acpi: numa: Create enum for memory_target access coordinates indexing
> >       acpi: numa: Add genport target allocation to the HMAT parsing
> >       acpi: Break out nesting for hmat_parse_locality()
> >       acpi: numa: Add setting of generic port system locality attributes
> >       acpi: numa: Add helper function to retrieve the performance attributes
> 
> Drive-by comment since this series isn't for me, but "acpi:" and
> "acpi: numa:" are new prefix styles that don't match the drivers/acpi/
> history.  It looks nice in *this* series, but not quite as nice in the
> future drivers/acpi history.

Missed this feedback over the holiday break. Will do better next time as
I don't want to rebase to reset the age of commits this close to the
merge window.
