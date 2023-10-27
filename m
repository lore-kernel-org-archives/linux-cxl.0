Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C2D1C05
	for <linux-cxl@vger.kernel.org>; Fri, 27 Oct 2023 04:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="Fk4FgNGx"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9F11B2
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 21:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDmn2yAqPP9MyskPP+xqfQmUfmS11Ptt5keWzXrGA4ABMPp5ekBGI9HnEzTfCKFjmiDVD8Y46t9wHZIPolltqEw8fxr2LRKKTZZ0n0VYO3a13LpyZQXH3rMYKtO66opdLtLHBISS57GnQB9SkzNPKeBCm68/lC6cF5NomHaWwj6t+Ovsv4Y5NHr4UNJ1/tcSJkL0jvLk/78tJfnqGs+XmEgLTwRIVmfrHAheSqWzjSx68WVc4GhS/XVRDstrt7LPWHrBhiSWFIx5gVdyNAd18opsDwbVLbhJApVmsGJgnloq52TR6ZqaV1uzKuR+zxbLMY5uysOyFSreDcATQsdD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hG1KW45Ue2MyZliuqdAcF/uddJTjMwP/IslmcaOhzNQ=;
 b=BzeoWAIdjEaHYRrlzisBFv/XVwhp/qOr3Zx314//Do+zORK3SE/RVF0Vdgcp/0vylU0Chng18zxfkpgG+yg3yIsDU4fYuk4xdm6jD4D9WFthaceo8KHzXTr2znZnJoYTReNIHQ8mGhnQSoRDAFtNJqnJe36OdWVWQ84xbhRAEdGqTAubZNRzUP61fOSYWtTyAHIl9zjYU482fh3L7Iwt1CgfSZicOHniYIEHx+7tWeW2u167WjIM4h4O9ffGbgHKglpAwHSf9vzXN2S/VynvecIaclAE62cXWlUiZb0MUfuU6+VgEPXkHMJhTfXWatCLbRLMGKiyVyXg3DqmKxLtIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hG1KW45Ue2MyZliuqdAcF/uddJTjMwP/IslmcaOhzNQ=;
 b=Fk4FgNGxrjCKdDECa0GZQPjBF7IH4l9RJ6YOWjBTksjWNqCU+ejshDNjb4HW9PP3XS8eHp0pnQaVS6X0iFuEN5o+prNSlKQSiKdGXOCto6qebpzDAjLrPJ1pdnuDBzYShx0cWjk8uSC4AMnHZKK++M0TKkH9d1LFz+VlgZFmoLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by DM6PR17MB3721.namprd17.prod.outlook.com (2603:10b6:5:251::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.8; Fri, 27 Oct
 2023 04:48:29 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6933.014; Fri, 27 Oct 2023
 04:48:28 +0000
Date: Fri, 27 Oct 2023 00:48:24 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: Re: [PATCH v11 20/22] cxl: Store QTG IDs and related info to the CXL
 memory device context
Message-ID: <ZTtBGA5X9BDOrjPI@memverge.com>
References: <169713674328.2205276.10184241477215488339.stgit@djiang5-mobl3>
 <169713693022.2205276.8814476945721343862.stgit@djiang5-mobl3>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169713693022.2205276.8814476945721343862.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR13CA0132.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::17) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|DM6PR17MB3721:EE_
X-MS-Office365-Filtering-Correlation-Id: df026c60-8338-4809-e52f-08dbd6a7f651
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FgJR4zo0gX6+ahQpZPAqto/5ActgTHr03J1awkvk26aFTVQc0uChpa/Zn0FswCLAW7eKPw9UzNHOErfrGxBxPOYmN1ioqLJo0GyIwxAzMeHgIxtkBjg4F7mfJb/xOkEGaWo9P2dTkUubgUMmBz1d486HzcUtuHIXDVg9Ppa0SLFZAA4wfFILuWri1JrIwG/TgwAd6gGE2cc8psuNGWvlhP7mCRoQDxgmdIF+wZh1M0h6wSmJiy6EXI6HgtFkrr5EuYp8L2e67lglHAHttt+dMhkBV2uVoqw1VYYF5zyrWCOjZdvirTdu98X1Gb4u9NIKRwaMmFPOjbzZUuyzIxa7Fo8+DPl9a7dGoMiqemf4IQZ9tZYEUcz0EOjs8ky1eI3Vr+T/JlJ34XL87NspAgIwVRnIooULAQtnphrXCVHrml1Oe2MAvGWyozPUlJIYUKv1YpLKUUfOlgH2jwcbbYg7WIQKGgRYYMmmP+LggY94FJDjGUNa3UIjVx7ZRkeeaexbOCbUBA4Gx75ZQ5LmLPjtDUhOJHTTwvRZJBBhTyBj6xjuXhiAMQvxY+SMlR2gipYo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(346002)(376002)(366004)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(38100700002)(86362001)(83380400001)(5660300002)(2616005)(6512007)(41300700001)(44832011)(36756003)(66556008)(316002)(66946007)(6916009)(66476007)(6666004)(6506007)(8676002)(26005)(6486002)(478600001)(4326008)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ToQCwDXbm41ewWafgFVIWftWRAKbWCTyy7G4K7VG19aYW4agv482x0HEWIRK?=
 =?us-ascii?Q?vf3YDO/L3FEp5Srr9zjjeX3ez3I2TPBLsgglb4gKdYfhrllRgUV5YCq7b3Zm?=
 =?us-ascii?Q?Iin2ln+9HSAfpwvYgPXX4f9wJ9fzHmOKqovVLGA/toWhvi72BXTMqIEw/gJs?=
 =?us-ascii?Q?O2DbqBM5riJgajpZEGVnPzmg68zRFIvzG+YFTif24YBFteaiuqUX4kqTpyar?=
 =?us-ascii?Q?wOqzV+5xijUHmEkhBdE4lbSDF+Bn3ZJrErzE/LpQvwG2MFY51q77HGeqsbvk?=
 =?us-ascii?Q?XxMd1WjYObdMyAp6JuHtA5pZ2xF8ZM3vuV5tjfIEP8KwiAoIygWpnW2D5x0A?=
 =?us-ascii?Q?nEW8sPXud3IC5ZN4MWcHBlV0UysAqLJ9wWy9y/38JjFUcx5zd0MTsDy+o/YD?=
 =?us-ascii?Q?dAjdtpsX3Juo6RIRThfr6LuhoC38t5h0aXb7nJ/6pOs0gBlYARvx+/c9KWPi?=
 =?us-ascii?Q?GTIbYB1NjbG9YC/Mzwyw2HLSEyw+E9u8RG4vIfAz2lwbo2Wom+Fee+PbcqSq?=
 =?us-ascii?Q?ntl/31O9rXISpUxE+7vV8IB3/3l/Hw9/djnaItFTtEypZZdUrQWIX9dFIVnt?=
 =?us-ascii?Q?+noYj3TuCLKm+oS+K5PIYg3ZF8Obk7FqFL1ssfqNB2jI+Lzw5rF2PUfOfOF1?=
 =?us-ascii?Q?JzAFtOEuQ5HRc6wud82sVmd9KosSGLLrSTc16Prgxf0+NHuJoT53cbQP4RhN?=
 =?us-ascii?Q?WVppa7Qx0tNZyPmX1CLG4zad/ykPEjm2FmEN7fY6+ZXYfETveVNpfBDP0X46?=
 =?us-ascii?Q?IgWqKr5+hulynE0++dfw3aIb0S8tFGiMjEsUrBkAlOHGefURfsCwaKL5JGOB?=
 =?us-ascii?Q?DW2oO8EtFMPM3g5n9AHnhdcsvjtyI8Gd7qSNnnvwfK7KfKu+CTUDMw6a9X2n?=
 =?us-ascii?Q?02ou6u/0wj4FheEFYOxph6WlLIQBh7Er16ycPL/CW2F966fqVte104RE1YQp?=
 =?us-ascii?Q?MXG9sfp4VwlFtYo5zXEViX4IEKhuD3t6w72rPGlvJ6F449HKwi2Rez7ArIwo?=
 =?us-ascii?Q?d7FRzTg33q9mXwwKXk3WFizBQpxILsf4l9BuTUsFeSu1q2dfIBShxJnEKh94?=
 =?us-ascii?Q?1w2M3u0lsOCHRGuaHy8jdKFHWYliMNvZ5h+7uO6pB+YioBpFyYy9Iv634r99?=
 =?us-ascii?Q?FJPuXxes46qBkucduuMZH7PMkWtDalnSUgScoKOA0rOg52gd7kM8a2SyObRS?=
 =?us-ascii?Q?Jb2xihb2ptWndhXPwKMrHeUghwmrxMWRjK5qjuWetHTmnXiqL1w9TD3h7cud?=
 =?us-ascii?Q?yMJN4cJgPXpfUZODXIZ2dpngXCVlTM6pwwj8WBSVY09kEbDHxnpAJ95ivwzy?=
 =?us-ascii?Q?hzLD1FSrttyWNFW4YGZ2GJbmxokOmHq60aERkC+HLXL+Rre68cXWtO6GtFGr?=
 =?us-ascii?Q?NjLze8hGnwwt/sx81I7JyaMClykNH47QfSlyQk2UsbervVjCyE930idcby1J?=
 =?us-ascii?Q?2c3AZbGZO5KRyfaghyLzrADy8Irptrhc6lEhOyTC3bYsEIiCWWmL2gt5Bbub?=
 =?us-ascii?Q?lINzUWeUlpuzQJMyJD65ygOur9+UaE9g0jrNnDg4CvBaTIHNB2DTSfiEprLd?=
 =?us-ascii?Q?6F1lDaBe57DernNe0T4nxbENf4/qcHz1PAjzfLA4m0EjXyFqCl+7mAnhjYo/?=
 =?us-ascii?Q?qA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df026c60-8338-4809-e52f-08dbd6a7f651
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 04:48:28.8720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ui6xoDEf1dhAKOaTwNadFdRcju0/X9lQyPWFwNCI/48KqlsySVDmFRrHptEhhO9k5MAj12axOKxeoD13hN2vmCKHMQhWOBNxNOXNPsRGm7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR17MB3721

On Thu, Oct 12, 2023 at 11:55:30AM -0700, Dave Jiang wrote:
> Once the QTG ID _DSM is executed successfully, the QTG ID is retrieved from
> the return package. Create a list of entries in the cxl_memdev context and
> store the QTG ID as qos_class token and the associated DPA range. This
> information can be exposed to user space via sysfs in order to help region
> setup for hot-plugged CXL memory devices.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v11:
> - Detected multiple entries and emit such case. (Jonathan)
> - Preserve first found entry if there are multiple entries.
> - Refactor dsmas processing paths in switch port (Jonathan)
> v10:
> - Store single qos_class value. (Dan)
> - Rename cxl_memdev_set_qtg() to cxl_memdev_set_qos_class()
> - Removed Jonathan's review tag due to code changes.
> ---
>  drivers/cxl/core/mbox.c |    1 +
>  drivers/cxl/cxlmem.h    |   23 ++++++++++++++++++
>  drivers/cxl/port.c      |   60 ++++++++++++++++++++++++++++++++++++++++++-----
>  3 files changed, 78 insertions(+), 6 deletions(-)
> 

This patch breaks creating regions for me with cxl-cli, it is unclear
why, but before the patch creating regions works, and after the patch it
breaks.

~Gregory

