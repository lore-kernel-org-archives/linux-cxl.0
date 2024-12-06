Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6BD23A9
	for <linux-cxl@vger.kernel.org>; Fri,  6 Dec 2024 00:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443251; cv=fail; b=ko/ma2PHyDLb/8iqox7QlSqOGDUJSIOV2tXV0BjErqAdRMD8illO7wPzJlwUfebF2gWeeEsmoh1mpJ1h6pZfLvmt8d8tca+7b15G9PJEtwR6ZMmpHX7K1A6EXlVQz4RVjX4ZCtzDWE8uKkoNT2lV23Gf9BF/o5d/zA383uy2tg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443251; c=relaxed/simple;
	bh=wCJNiurBS3LecQrffeSGJXIeEc73SYMsYeM9V0I7Xg8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oO6rbqus7XBoNS3qKNL5skRNYh7+3oF048qH48RPAP/zw/ZygFn9bJ8QVBhhDw11vjMs+r6KPGQN9f+8ghdDAJiHeBrQaXcBFCaxUwy+ephCsZhTVW7I4aOp2qfmXCQTYpeCKHLUniuTdHCaeuZczVxfkC6RLUvj65b7iQMoLVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3Lamt+V; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3Lamt+V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733443250; x=1764979250;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wCJNiurBS3LecQrffeSGJXIeEc73SYMsYeM9V0I7Xg8=;
  b=I3Lamt+VHFl8VLhnFEpeAnFEwa1z7tHZ3qsV8crxhMwnf+TmcVU+eL2K
   mLQn+dlpq8HofO5pVYCnZPZokTa+aCth3R9a8bUET1LZ5Zx33VXXB5wrm
   0K8IIk7VUFVW2g3KtOSAb2L4b9RmMYHWfY9z24hCD2cAuIWwl/+uEeK3Z
   ScbVsImMyqadsXn3B+jc3DAZQtTqTHdv9aXEirezi+P+8UXIjAOn+Lme3
   Jbqkewz2xT7aEagXvkYcj56q4EHbIV/AUwe0YUsCEA+pl/n4JvxY6AmB+
   yV4H83hHVbQWZrCvw9Ap8DNkvAwJ+/oYJSHIvUa8vARnyF6Jpxv1wRpWr
   A==;
X-CSE-ConnectionGUID: X8c69V2GSOSASA1/XpjcAQ==
X-CSE-MsgGUID: qz5WeOn5QreKDRNBlwM8Bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="33934043"
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="33934043"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 16:00:50 -0800
X-CSE-ConnectionGUID: fW5UZQdETXmVJj+9RVxNVw==
X-CSE-MsgGUID: kDrYzjxbQ4WZOsjQDUD1SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,211,1728975600"; 
   d="scan'208";a="94118266"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2024 16:00:48 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Dec 2024 16:00:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Dec 2024 16:00:47 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 16:00:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVumz8xTZ7GAdKyP6lzh2lSUSig/jIvOpZ8CArX/9YgjVFqin2TNcI/kpExZ/y9npFHQtjNiTa3DiPw/KXE6xi5ppK7fnT/dJwKjgpZqg0NQE5LrAFDgXKFEDGK9ZfXwq9Kw2r3zjUyRXU5s/9TI6or+QRC244UxVSFgcZpxlrRmC3IB7T46AZn1DRTTQqHlDG0gSbwEcWVjagyzXl5+VuoXJx5rZ+boyCNk471uycDYmoduWpJ6+d5xxuDdt0zcJHkWwZpN7cmk4c70wU5dAKdsHAO3Hx03MtDr1suUe+/ofopBVGrhCMtqj90g5wQWQDtoRClDzvV5XWrhfPRpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSjTLFt9E7eNynInPMnx/MqYFQsDTSA5TO0Hg5F5kjM=;
 b=dU870KpskyPzWNh17CKzKCgZRTmh46WVfK+wPxwzXJ1I2UZ9846y6AoZoR5Bt0OppQhIDtSOjuEdSwzk+vqs2OmowznKMvWKMYv5bFd7tB0l1BF5a/PdHAuVCxkSBQJz2x6UVmOE5gQi1U810CdOQnyyvLsOSV1s1aSMgOLgdj711DUMSFmJ855QvDtdjxTf4Mwp3kT0EY+9qqGpAk1gX0uWs1SqG5ouGd8ZAgTXN0lZ9JWOZDo7v/4mEXLsmclhYIydCH4kkL9I9M41mXO/H6J9hYjW/uAF6XrCXXrEhNQ/G6JRkA5ud2qgXS6uNkpun3evBjM4Dg9ll7+lUjYzxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB6665.namprd11.prod.outlook.com (2603:10b6:303:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Fri, 6 Dec
 2024 00:00:45 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.8230.010; Fri, 6 Dec 2024
 00:00:44 +0000
Date: Thu, 5 Dec 2024 16:00:42 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <jgg@nvidia.com>,
	<shiju.jose@huawei.com>
Subject: Re: [RFC PATCH v2 01/20] cxl: Refactor user ioctl command path from
 mds to mailbox
Message-ID: <67523eaa35b40_2507329470@dwillia2-xfh.jf.intel.com.notmuch>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-2-dave.jiang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-2-dave.jiang@intel.com>
X-ClientProxiedBy: MW4PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:303:6a::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 6850d720-e76c-48fb-2cc1-08dd15890819
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gm3m7FnPOzFlidjoSNSofFlx9Ga/jyms1uxOpzF5xecdIvdEkSsZYlQoVSwX?=
 =?us-ascii?Q?953v+8hZt4qZVZp8uOA046tzF7MUtjaAwuXsILMcEbejPbqZFvVcfd6ycaAe?=
 =?us-ascii?Q?aYSQ1GmtJgBa69p9ukUhRtmdzrBr7jgGXk/Qol73ksCYTf8bRB5A30tHYb9E?=
 =?us-ascii?Q?gTbU4S1tmTCWIgqbOiH6LzlGJqm50PcAlHwPtSRb0Br2kWZOyVeoNhj5jfO3?=
 =?us-ascii?Q?RAaM5jWUDl79Zg+efsopiTAVqbhcxwWXD0ADZ5LPmjpzLLRbDS+W+v0YDN2f?=
 =?us-ascii?Q?cvbdCTQ2XHI5L3MNRRdZulz9/FsdaOyzReh/RtG7Q7Q4xKjmcbzXoXjXDen2?=
 =?us-ascii?Q?36agCr/rvsvgdaJlpozVQNEsaJafwmfKE64Ha1wSCdfoeEmG5OqGR4sovpXd?=
 =?us-ascii?Q?UxSKveEWb8tQjda6L2GZw28OOJykzgacMrNvw8c1E3VaoUa0WaxLE7sgqn0I?=
 =?us-ascii?Q?uPCzhnqcFOHHYSwmosvFWbDsLiFt5i5jfFEkvCz3EXiSJngRk28+kxEo/MtE?=
 =?us-ascii?Q?e6GRs7DGAOWuTC556As6vPicdjFr2jZfP0O+yWS9c6w3ss7o8XxX4LL2plDM?=
 =?us-ascii?Q?wQT47FxxOiI4bcDAkFT0VCLna2YcIy06052wkl4bu5PmL7V8px3oEzKZ6R8h?=
 =?us-ascii?Q?Hzr8Y3s5QmcKg8RTX74m+SOmxwY4L5toR92vQnRkjzhQQpdYwa/vMhR9jFZI?=
 =?us-ascii?Q?3tnoIJilYnqvpjx3d5jd02JbMVkjoxXAY9hrjbfyXjW8PLnKMvwQ9GmApHQ3?=
 =?us-ascii?Q?okygZULgVSvD2N1CZ3LC29f6IE6hls4Ih7loJR+MnVxqqghTIwuPVy44DbRZ?=
 =?us-ascii?Q?4uaXnWfSNiJ6xNwQqoqlzBioH8kJes0TaCdzRTJSsk7z6VbaWrUpw+SrClGk?=
 =?us-ascii?Q?xVIimaf/DBTRmQnSxVy2v7u1OJVFF7q9YT0HFfkzwZauuEDGkTcTQSGPCtur?=
 =?us-ascii?Q?wUk+16MxCX2SvxF7ZA7dVcSy39wVpzq/MWyiHQkCpjGMjqxC/IHNJsXhavqY?=
 =?us-ascii?Q?xtZEEHHGtwX1+9Sjgk2alC+z/jPWMwKMWn12fbR/YSujxwAAX2BivU37sMrl?=
 =?us-ascii?Q?WccVKz5ozvkMv/g8ZwrlZBb/7JVzO5qH/T76Qtv7dFveBGVdM+OmYWTolDcd?=
 =?us-ascii?Q?UynbVM6Ps9an8COh88Q9BCl6UKEpC1UL8bM5ibFxXWJGXztABQnN0zYq5JGB?=
 =?us-ascii?Q?/HxtWSneEW8BeR4bGNl2Oi6EiL8LkvFRrizXxVuuBCv6WVGtmYIK3+6jPdKp?=
 =?us-ascii?Q?Xd/bBDP4sVTxmCZaOU0Op861jxekOiS3wcL0DPaKn322dFAYZb9PbX4Mi1Oa?=
 =?us-ascii?Q?FUGd+Cmfzq2fEFHkEFHZlpvfoenuRkoCRR9V3ShGzMF/1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GkVlBt5rCdQ2HqrKIobYooJobF1rYwrj7g5ElyC0JgtsrXkrhPbvduKr3lro?=
 =?us-ascii?Q?HWbxRLw38+qQNrupR+oQwkGzhtZFrf+idIrlpWmZ1w1vQX7VIcuL0J0QE0eY?=
 =?us-ascii?Q?2f5Nm2Rdj+UMQYDmD6TWVYoh102yciUuPX0g0ZmxTqQ9/wE/YbUDqWmhYeCW?=
 =?us-ascii?Q?nrDYjkmUlcUu67kqJ82eNJW0nSqsvaFT8xE8LDsMu4bcbXV1C3n8OxWUeBHN?=
 =?us-ascii?Q?9NsplpgOBfS+4rdFOcaU/5BrHKPtIRxiqTkE1+dd+uoMh5PkkG/QLdYrzljV?=
 =?us-ascii?Q?qAJJDChFRm++lZWP31eb2+c5esJGR1XtMFOuT7xO80Ksp8CRARNmvp1zj3HL?=
 =?us-ascii?Q?hYFEnxzPK3NaxWTUmqzRx6bii54E94v/mpjMfNlRfkQUQntvzM79VuP9Rpcm?=
 =?us-ascii?Q?TwtlooDeVrzvIENTJq4AT645AIMkzP9Jz7kNpiGRmJUNzAurh8LwvDeOapJD?=
 =?us-ascii?Q?JrczpjFVnxaFWkFfEiI1tb1L/ZxyLQAkHV3BRHfIo4I35TSgiZvtBPUJgAmC?=
 =?us-ascii?Q?WNCSMe6gZf9qN9JaO2OfndNSYDYlG+5aybSAW+C/qbygTtE7tgNV9k7gHqbW?=
 =?us-ascii?Q?/lrcilVbtxsjhoTmoMdfWZ6OFeapM7O3ih9+kOYx/7zgVTzLKkEeMuFc1Cvf?=
 =?us-ascii?Q?mYa+XNc1E6icyUSoCDZiSXICbKHuPN6o5nEWqgUAuwQkps38yXIa8Z3cyjA5?=
 =?us-ascii?Q?2QOl6k6EXguuLrbql5R8NKxxP+Kp2Oqw7/b9VN6ETwytA25H9mHN1MzqrTYw?=
 =?us-ascii?Q?55oeXQSeI1Z9PtZ5O7h6HDiEV0jC8QZM1kn3zgkkg+xHxkmjZUFRq+ZQHOB3?=
 =?us-ascii?Q?BZAO68O6JH4dnwv+8jJ4VlyaRtYtr0MRE0BpSVzFLr8FBsViMwK6v+UV6LG/?=
 =?us-ascii?Q?XKhGXpFb1FV6Lxs9FHd6kCzHJvMGg8RzYFoXeEFjK+WqKWsG90LD2Yn28FDI?=
 =?us-ascii?Q?mQxI+Pk0cGE5vMXa7Ytd+wwa1/iidviOFikBLtdNwTpy1R1H9/dl20V+MEex?=
 =?us-ascii?Q?qJKEhjD5kICGBD52hSJ3d0Zdwt04am755SfcZEgfZYTSyHg/AEPQC0CwIVcu?=
 =?us-ascii?Q?24aFxoKfB8KfLySxTqBt2ov2wIQWeDymBD3RUSRcNoh6cMiWmmwkZq1ZhOgu?=
 =?us-ascii?Q?L9vDYGNQ3Rv1GQojDLRZoeKt+5YFVwyX+WXd1x9wenZEJYSj+YknODP3JxL+?=
 =?us-ascii?Q?rRcD2QobYG5n5sLS108SY70APORDH8rK4xbTWUiruMPJGxXJGamN5FLdiFbH?=
 =?us-ascii?Q?mBAlZIcJzQW/dsRpJqKfk6KVLeb/fxvBpCaG4m5tMfcyY4NURb0v8hUXjL/I?=
 =?us-ascii?Q?l+f4Q/jBDQ4t5LbWxXVEpn8uEMDrVeRZ1dPJ8HNIyqxd+d7VD7Ij+tLrbEaQ?=
 =?us-ascii?Q?4YzVQquT3fZ233nWF11KqCRKmd+DG/9RzXmfvgbZclL2A7x8ikEQpxGxqECg?=
 =?us-ascii?Q?uDJ7PmHYhMI46A1V2IFwdWErZDY0okow87gsJNw5Glk4BS+vxuckB04OnWZ6?=
 =?us-ascii?Q?JK4TwQWs0qBbGcHYAP/zL7l/JEtETGNwkC+BQu3iI57FoX2g+0urX7u7+1QY?=
 =?us-ascii?Q?0FGmPicnMBOPGRilJE9w/B7OCQmKjAF5LcYGEsVQ9a9bXSnKrPykfoKjItyL?=
 =?us-ascii?Q?cQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6850d720-e76c-48fb-2cc1-08dd15890819
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 00:00:44.8560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PA9Hk9DZksslzMxZRNpx60enh/wiItFCF04uX/2QFfzJHQ2C+Nmxj/6wD6foBKz0q33e0GTUs02mubsPJT/0lo1E+/KgfZ9iCCyjDcrE43k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6665
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> With 'struct cxl_mailbox' context introduced, the helper functions
> cxl_query_cmd() and cxl_send_cmd() can take a cxl_mailbox directly
> rather than a cxl_memdev parameter. Refactor to use cxl_mailbox
> directly.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

LGTM

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
