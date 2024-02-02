Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAEA17542
	for <linux-cxl@vger.kernel.org>; Fri,  2 Feb 2024 05:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706851692; cv=fail; b=RMMJpsWvggYNcpE+v5SQB/45IeJCFoGswYlxokZiGcfbgWUOU+vmO2ETxzktJ/VAx6cVJsi8M7bqcbEHFeE7T1sqaVqWFBBIu9rTXQCU/+dvhChyrUry/462ORlw0wS/pEwIWKt/vkCm6QS++zhL6dyVe3TO22OUAFN+896gLxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706851692; c=relaxed/simple;
	bh=7b1RJnf0Ac4c5pcdNAjH+hVjhqLYGVRQ5N39dpaZvx0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EodyMdFamkqtiyLQKvrOvjZIHCm0jZk0KABVKOOoPcNFyNQhvHYMGrFNVoSJe+IRbmbOtggDz7GW0V4Xthb8EgwGMEWa7qxNoD04pgJKgM3Ol2j+si5NNj+MHhvjJSyMeQnFqAuEZUTVYgtHp3qF0lc4LAo/0KA0L0W5rQj4uBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TWwrYUeb; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TWwrYUeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706851690; x=1738387690;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=7b1RJnf0Ac4c5pcdNAjH+hVjhqLYGVRQ5N39dpaZvx0=;
  b=TWwrYUebuuurHWjnMUvo0O+Fwou06S/wfmRCP+vq5Y0+2HWqGoRToTPV
   pFvLjlvfl2lQBKO//RgKq1MyrHKGDgJon1VYX7u46yCeFisSsBs8KYXR0
   UomUOaXqRpwvYPB2lmNcN9EmeAI9spUyhpzgJcQxR4P20alEJuM8TC/+l
   Zb1j0vVeRV45csLtL+/Keq1mPZbumzp4yhcR6tV2kHNQZSlnCXkbNLl74
   bsYyy51zzItEfpFojse14OEXely/pJ71ZMa54i+cMxLg8zVZ8C0oq+QxR
   dggWmDmZbJRVFYvppu04ivO64SKWIGt7XDWG8dfhCc9TkmkZ9jpOdD0xh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="10702871"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="10702871"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 21:28:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="293084"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 21:28:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 21:28:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 21:28:08 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 21:28:08 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 21:28:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E7ooVnYLORfoVc9kQWfY3F+DbXQPh7Ns46Q6nmy30FYaOlv9MVoZA5ct0zQCgh3Aw0yDBZI7IsXY337eCjc6AfCo22qjaNLDk3LXMM3U0F39z7tayxJnMe5XEJ02WvdNqRkyQyiHeAjF/vrIed6OUgaZ3ByVLgJLWU+/ZMyKY0ZFqHAHWz75SA045cKpCthLBGZDcfsrDLIfMOGdyGJU/rHzeRn21dx0J/yWyIww4SHzxF/bPDtSqZME4uY7DdOB1n+niotTNpp/FPdziDuHyMfef/JdQgYnHOEckrZtK5w0378U7Vz1VI8PN75bVnAIsq4Fd5E64mKZ4KX+O8SPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFvkM3cOQfSYacCzL150/p95K97ibSQKQxAAdhtsVAw=;
 b=U+joqku/y7jXHBot94ePgK8AtIPtJYCmRdmbZAJvZ7wHm3j874NQ2XG6dDyPBxAtWVBCohkW6k/5bxLCBZYuUcUmOAIMzjhgAGVL8yIQCoSQjX2VInT4sZFIL7oDA5t6Qn4AcKvN5FoAkx+tp1A+77cnATHXCJVMtxg8ljaysV+xBCKja/9gGZuTsk4XZVmfeNhPLaVPc70rGXqYQ4HBh2hq23cNmMsLzjR21ZHvUjrTBfEx0BF/cBOfY21hGSSNdHVtVws6tOgw+RlQdvPdy+rTz3njLz4T9pbgfTXQp+jz8GljEWc4VPpVwWJk6QZk+eF1udNzI2hJDvVazWUd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4659.namprd11.prod.outlook.com (2603:10b6:5:2a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.28; Fri, 2 Feb
 2024 05:28:05 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Fri, 2 Feb 2024
 05:28:05 +0000
Date: Thu, 1 Feb 2024 21:28:02 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Wonjae Lee <wj28.lee@samsung.com>, Dave Jiang <dave.jiang@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "Jonathan.Cameron@huawei.com"
	<Jonathan.Cameron@huawei.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	KyungSan Kim <ks0204.kim@samsung.com>, Hojin Nam <hj96.nam@samsung.com>
Subject: RE: [PATCH v3 1/3] cxl: Change 'struct cxl_memdev_state' *_perf_list
 to single 'struct cxl_dpa_perf'
Message-ID: <65bc7d62d42e5_65b26294dc@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240201214731.1297389-1-dave.jiang@intel.com>
 <CGME20240201214822epcas2p3062089e1281f483fb26eea3c80a71475@epcms2p3>
 <20240202042140epcms2p3c6f0708e85374e958df2f58416dde705@epcms2p3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240202042140epcms2p3c6f0708e85374e958df2f58416dde705@epcms2p3>
X-ClientProxiedBy: MW2PR2101CA0006.namprd21.prod.outlook.com
 (2603:10b6:302:1::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4659:EE_
X-MS-Office365-Filtering-Correlation-Id: 77bb82bf-d297-4eca-a661-08dc23afbb85
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8zGayCSp7Q9QFpAJ0X2XlIQ3UmxqSO7dHuFwfQujMsM2Xd5T9iwLOARIsWDRXz7KCelT6WxMEMQOvHrFtn6NOSW2Es7HsOV3xGHk1TNBNEOqi51MzKI33t/QIxr7SyZU9OvNhrJ8KdnbiCWNCP7ta1/XhJ694CD/YVRshj1ZzBOZwIwjpRh920CwHna+2rye/sE3zyzR7tl6jtydufPBQ5xhuUox7Y7ogUzh/6Gy49q/BLYp5Zu42SuiSv4ul8zYHN2CvgngaZ3Cm72EoCK6kdEoPgX8quqUdlXqpQah9y5HYTtmiHb725mS29RhWxNmQDsAvWiBeSnKh+XtfW+q6WBgo+DDaLaiBfrMCAEWU86eZVQw5wUMT35rUfEjSpkevmSU0XZmP+8LgFYg6xGd/hPtqUD7sxxgFxAM2xDQTmqZwG6vb5qJqvWyXHinSeS80SuYPFtyhyeNueDxsAmylA+SxsS3baJ/PtkpMoHNOx6uVLhZEg/089nWa4bi7VA1CZXi52lMKASRnaGPAMuDOHeEX3ryQAiOPVjlNxRBQs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(66556008)(316002)(110136005)(66946007)(66476007)(4326008)(54906003)(8936002)(6486002)(966005)(86362001)(478600001)(8676002)(5660300002)(2906002)(41300700001)(83380400001)(26005)(38100700002)(82960400001)(6506007)(9686003)(6512007)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jyH6YpPNSl8jnl0fosw+RhN+obeMZ7UEFyrPmGYXwBW4DFTd2RJExbvkY9tX?=
 =?us-ascii?Q?7Vs36rg9RlQ2eNWrJCjeDh7mBCYJzBOUKk/gU5FC/cAAW7iDM9RD0XOjoGes?=
 =?us-ascii?Q?Ys5eVZErdODfYw5OkEsQAvaQTB/PhswsSgC5c3mepGeczNl26yxGyaNfvyJk?=
 =?us-ascii?Q?ySFWidtF5wFzqG6EJXhg0SNv2E5kv36gkrtY5PjnpxajRD7EUIkxU9fPsNKC?=
 =?us-ascii?Q?Zpo89gGdx8zpoKEd305idQdo1p971Ig9n0uV0ufioAtm6UvPTbe2AYmExiMN?=
 =?us-ascii?Q?ky+4xOutM1hOwRQUQrgGwJhsKihTwH34kj+oITG23ahSO5kAIlgerIAkpO0e?=
 =?us-ascii?Q?/nzE/pG9LgXQ1P7/tUuFT+AefXxLyJr8VIk2rjoubRiaYLcadTiZBuZSgrsd?=
 =?us-ascii?Q?aPoY9ygDfJwC86xn69wFaae6GwqavU/BmC4Mr6aDtxCDwa+3RzvrillXIBvX?=
 =?us-ascii?Q?qm1/7uOlP6GhKQAAZuWosr7pszMWou5iWbhHdZ1AcKH1JK6KHoGoJ1Zpj/Tk?=
 =?us-ascii?Q?kg/1DXZ5uRUVoCwMqJQ3jNCFOvRTHG27rmY38n1zoA27Ae4rzi29OLIb+OKQ?=
 =?us-ascii?Q?GP3UXKvR1dCm68QNFzgQNH7FZp7YwlFxrU1h/h4ROOSRanls21R86QO/ZTrm?=
 =?us-ascii?Q?eQI5o4h98zq/RC/74wqOYzt8+lPD6W3pW4EDQ1zpEtNahK/n+lEhgkoYHtKu?=
 =?us-ascii?Q?3GpyXxnNn+Gl8PQuPP7GsU6Ctatcjio/970wzbsRvuEf0j6ESneFXPYiVowY?=
 =?us-ascii?Q?lC1RklxL00wmx16uRyUX/NYuhyAs77ES6G8VIAsOZG+6CETS4QpHegAcZiwm?=
 =?us-ascii?Q?NNOyLw06U4cmpQn8pUQucYLvYoQWNN2fIpNSP6NGBMbSLqAPSXsm3mQOHxcu?=
 =?us-ascii?Q?sNyCB5J3qDcM2uO7Q7A92b2+4cAWaIzYnm3XNPJ2ZJH/CsQXNUvexmsmWv0b?=
 =?us-ascii?Q?KN0DYs2rRWWXci51llKYpLYJRobsoz7iR8ZE4+X9KhXS+0f3Mgrhz8AxzehJ?=
 =?us-ascii?Q?1Jv4d9yRqdkG60GN98SCJeSw/T5Py1GfVuGKFSLeiwWnIUYj4mErrE5q1Zqd?=
 =?us-ascii?Q?Et4lQarbPJ1VXPk0+U7GwXm+jjYH1KCuDYk2+iCFk1z0/5pU86qn61qlPZ/0?=
 =?us-ascii?Q?20kDWL8QSqdKkQSVCuqELTcn6OBbcbHGxV4s7WpjZiK+z9ZkmAWhCeLvC43Y?=
 =?us-ascii?Q?8++f3lleHf6Y6HXaGAD02jmgo36+VtRN4PScaqxd+eLNaksmzMRLoHKXXCbP?=
 =?us-ascii?Q?IVjRIPO4V4zYFXfXNtMWqm2OhGEesI/ynk+pirGzJ9pZ+Ef+Un0qtpPEbg6x?=
 =?us-ascii?Q?QRFcN79T/Pp7NzZuP8AKfOec4rvghvGiMLtkSWWXJHoKsJnJEH1dsC6v04ir?=
 =?us-ascii?Q?kTX/NnImYWLvSNXqLBMQ6T3qO9JOAiWYtAVoRH8VA6oijGvSHQBNPMaPCBl7?=
 =?us-ascii?Q?o2CQYc0TbOgRjH5Qk7SPD6G1KkewCXakw22e3vrDuLTrivtlKB/AqM8kixtM?=
 =?us-ascii?Q?RpEsdAj4r+U/uW+5PPjlOWsxn+SAdx5qcxZpsClSvy9uHiV76VzDEgABTzve?=
 =?us-ascii?Q?zPY0ZJnx4pO+gznvqGhD27D/AQ1ZGuefbAFmSlU2wA9CUijfOjgeInXTOw/O?=
 =?us-ascii?Q?2Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77bb82bf-d297-4eca-a661-08dc23afbb85
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 05:28:05.3589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6NU++udRnc/E3Ly3CXVbz6Uh08OoXEUOWdBZjwcPaqsltisRnnRYW8IteZb9s8w0xg3Z1wZxbs7flATmd3fToS2UH2ClKsBdMpOHq0600fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4659
X-OriginatorOrg: intel.com

Wonjae Lee wrote:
> On Thu, Feb 01, 2024 at 02:47:29PM -0700, Dave Jiang wrote:
> > In order to address the issue with being able to expose qos_class sysfs
> > attributes under 'ram' and 'pmem' sub-directories, the attributes must
> > be defined as static attributes rather than under driver->dev_groups.
> > To avoid implementing locking for accessing the 'struct cxl_dpa_perf`
> > lists, convert the list to a single 'struct cxl_dpa_perf' entry in
> > preparation to move the attributes to statically defined.
> >
> > While theoretically a partition may have multiple qos_class via CDAT, this
> > has not been encountered with testing on available hardware. The code is
> > simplified for now to not support the complex case until a use case is
> > needed to support that.
> >
> > Link: https://lore.kernel.org/linux-cxl/65b200ba228f_2d43c29468@dwillia2-mobl3.amr.corp.intel.com.notmuch/
> > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > ---
> > v3:
> > - Add to commit log about simplification (Dan)
> > - Remove check for dev->driver (Dan)
> > - Remove check for invalid qos_class (Dan)
> > ---
> >  drivers/cxl/core/cdat.c | 81 ++++++++++++-----------------------------
> >  drivers/cxl/core/mbox.c |  4 +-
> >  drivers/cxl/cxlmem.h    | 10 ++---
> >  drivers/cxl/mem.c       | 28 ++------------
> >  4 files changed, 33 insertions(+), 90 deletions(-)
> >
[..]
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index 6fe11546889f..55b82dfd794b 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> > @@ -293,24 +270,25 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
> >   return 0;
> >  }
> >
> > +static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
> > +{
> > + memset(&dpa_perf, 0, sizeof(*dpa_perf));
> 
> Hello,
> 
> I think you meant dpa_perf instead of &dpa_perf, right?
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index 5c93bf9d5253..7091619f12a9 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -272,7 +272,7 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
> 
>  static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
>  {
> -       memset(&dpa_perf, 0, sizeof(*dpa_perf));
> +       memset(dpa_perf, 0, sizeof(*dpa_perf));

Good catch!

...or even better kill this function and just do:

    *dpa_perf = { 0 };
