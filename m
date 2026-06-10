Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77658370ADE
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 04:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781066199; cv=fail; b=fahqggdoAhwdAZvyxGfgL0qh17FghljydEoJbBr20UxjxkBfecND3YsgEAApMRU3QY9gtPCoaDmYp/AJeDdlowOzyB5pkgp1Mivpkd+3G77IhzXFr3aM1rKSf4G55Wiho2RuBvc6rxmU/NPBelgK4V6W6RNE2svWnV3wWJbtFzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781066199; c=relaxed/simple;
	bh=LtsyWcIOVE1Ix7juXbBahFxgWXN2q69XtoIWs30OITY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FW0I8Zfw0/1EsE2CbpuANFYbzraIfymmjTaXNG2gI50BeX8pjKK8ZkXZMo+cFlPRa8GR4JqDkcQRqCHU+X4cfSM1DvsjZw2CmrT6WddTGjPDmeQC+HS2d1Y2mDpDiahBRKFAtpyCf+6j9ts8lO+6lOq/Ki7gzxn5OnKusE781Vk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ihZdnw7R; arc=fail smtp.client-ip=40.107.208.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ihZdnw7R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JncOtUBzg9FF68Gpbo7Yvc8jb9xAKP+yt545j9l5uqzEhMvTX2MLo8h5oaekoSqv2hrB2IUgYA6/7DhvL7a1JRNxLGxcPPt9/SU3CHGXfSmRnW3Pc0CnnHaXC27+RQzMj/lfxKoRi48ptJUuQEgTknDHtTXl4Axa1nsG0VDrubSO3zyp9WsiK9h9fQJ/O2yHzZ/nUQJVbaHDXHGD4fGPYQYmNJoGjmSabUzJ0gkM4QOs1PzAI8387JvC1KL2+r4L9Ua/scjrkL/498G069pdPW+hbqOEvBJgQGvWi9h9sTsZwiJN2OsQUJAd6atyQyx1CwbgQf2K5UZiB54LtvuW0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRAaO7LRTGLYW4ygI4Qg8NKyXtGYjWIrzqjh1zmcI0Y=;
 b=cq3mLwpOa9YoKFHGwWQgis0/RPUn8Ou+My9TVgYtaHPHDLO6OLc5jOiCv6BbdYDSv0Zv//tLYPg2sDVRxIe1NklJme27tY62fC/JwQsYmagVveTipyfSZ5SJ0pvprVCb735kFV+CXcOl9ijeBKw0mQh0VKQmc4UApI5lyhkR1UY+Of2D/3zX9arGAtQqJTGAaFqg/q0IOcNlSmKtQi7T6JoqsLgqfl/F+Oi1F1P27yEtdGnU7zuF9ko/G/Li45FQ0CensegslFXaI1bL0jOLJ6638Uh70fzChHd4S1JmK0q9rJ6DL539p8pLgbzfxfUamAquYpnbtsNscsVdKU42FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRAaO7LRTGLYW4ygI4Qg8NKyXtGYjWIrzqjh1zmcI0Y=;
 b=ihZdnw7RKzXQUAOyqnpHT5CaNVNNkMDGK7TSjx+hFZ+H4TEZ7/KeP8QSZelDf0LQP7LU+Bf1LSI6WO5Z8fzBvzXkAIV8PxQxfU9vsq+iAE54PLMeVRLijFmxITNM+P+4AqCoB/6NqBfNEFWIzhn3s073Jp4gta5AjyCifOLladiSSafYZ0D2wNNmKK5SUELixkPefiZ8rGIhwh3ctlza/yaZDDJnJxmOHqb8AG3C71pH0w27zP3+VEMNzpD/DUxyIVjkWmNwKOzOv3me50Zx6pxniQh7888yjQdL2TRwhLCFeU6jjDmBFcGNXVwyEF/D2/ITy60QEKwMPxc5PIq/5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ5PPF183341E5B.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 04:36:33 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 04:36:30 +0000
Date: Wed, 10 Jun 2026 12:36:23 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Dan Williams <djbw@kernel.org>
Subject: Re: [PATCH] cxl/port: update reference to removed
 CONFIG_PROVE_CXL_LOCKING
Message-ID: <aijpFz9i34GBori-@MWDK4CY14F>
References: <20260610042101.222349-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610042101.222349-1-enelsonmoore@gmail.com>
X-ClientProxiedBy: TP0P295CA0001.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ5PPF183341E5B:EE_
X-MS-Office365-Filtering-Correlation-Id: fffa313c-fdc3-407e-6063-08dec6a9d72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|22082099003|18002099003|6133799003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	4ztqPT+YJOLFZx/5JkVsXSh4zI9OTwXdCCw2nYnLqQvW7LUExG45h2mEx0V+NyJ+rpsaHjnkGb2UsL3Hv/ByrELACt1Pqu1jXzyHSTpCyIuVkaP8Gyp167i3AzDg4tZWRhU83/o4PC9EmX0DQ/f+bkxfdTv5+LOfvS+o1q0JCv/SsiOOgMuOl29kvh2VrwTnqPjqdkZ2SADhpmEUz4mKUY9Pb/TZXvw5PFblxss2337G1L1zKQnIL5pkMctPwp8Ns5o5OSxj97x1ZK1MVmoj45hkaMfbX2G0hL03ZXDLPtTNbtfjx2zPBnHLE5yKhuGi6/WD3tJPGBNfwTHj1MK0w3xjm9rUKefWXK/flRr1QfUN/VQg2PCISM9e5/pyPFS5ZcpHaOGaCUvPC6kLjXD4DTHgcrfqI6LN2wGTc7ABhcKvnD+Ycvh7xxTk8VMc6vOF0XZAQR2n6spSTP+HdyO1rEtUkmdMMJJZ2GJAiPk4BK1UVGMaxGM2YHu5W8cfQ0yR9TQErLKH21LmZmzuLhjNp8yNBd8WSPgTg1BOjYYGiK1nlvqF7nD5XA58vVC9Z/9LDEGuBPoroJYqUapL+4gUm6h9/QPOWuZwFtG86h1At3kBe+6QU+gVK0UYH7dufu1QgwH45xlNpcrdcgvWOzim0hDTIkfehTpQYms7vX4WoepznterXw7VcBkjjbhmcbla
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(6133799003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?krZcofdO+fI8viXS9s9g1qBmzLJ5E9iQr+8m4nswJUsNNYmclUmWvmF5FWEt?=
 =?us-ascii?Q?wwalDNZ09Z2qEp3Gj5N18zNlHYyg2NR45H5tne9WGzN4Obj7SfHju1TM/R9+?=
 =?us-ascii?Q?QVBwnq11i4BdivXTgezgc+f+aM1FON5BSdzIaGEyphkm389emoZZkfsk9KH1?=
 =?us-ascii?Q?4cHj0IWG7DjTIg1Ota3lLk2XhF4h6fQGVplZhBBA95gRXUwiebK0/TZIJ8+m?=
 =?us-ascii?Q?ln0BJKkQzwZh+k3qy/Y0tjTlBuxvw+N7U/OxJZdUF2jg1Nh/ksXK5fXgYUWX?=
 =?us-ascii?Q?TdG0dQHGuGUAtRBt9KlJedCsXzmbwXmVyTHS2YhBoB2rGX65Rp7uykG80Jtk?=
 =?us-ascii?Q?a8mj9KE+eQxtQf+rO3lDqK1gRNVjtTExv3WqdqvTVNchYOJQW0cY5vvK0Aki?=
 =?us-ascii?Q?V0Y2DQyCeGij3vnJJ1bvnOqu7VG/4YNzqKI7DVhQuza24pNCBFb3FKhhfTg6?=
 =?us-ascii?Q?zFeEuzbIMOcv0tl9OuMIVt2e17XnnYuZ+5AofWkI0hxjZgN3adsB8Hxt5rOg?=
 =?us-ascii?Q?/ILoLdADf/CCo/sSZoJkHN52j7WBio5j0O2HDxFT+p6fX2LneBRdXDYcZsu0?=
 =?us-ascii?Q?m9axDUhWuQktDDqjm58G2irCpxcRCz1oyOI0zeoJN4iFg836X2UDAwM/45MC?=
 =?us-ascii?Q?BARGTNuYwjE1ysWrvAL+79HKNZYqZ4yCbMG0B/UKqtQ3b4aJoUTHVbPbr7+a?=
 =?us-ascii?Q?qcZIQhekH+om9+8oGa2rNJCJQGYca9UWQw241KPWG6cyubvh4f6R3nG5HXoF?=
 =?us-ascii?Q?ORomBNZ9Iz7QhXu85m3eHe641/EaB1THs9CCioZzpGCloYiFPJkilQpGA37k?=
 =?us-ascii?Q?DVtl9+cqo+PZdPw41lElxqo9k1EARGmydrKSVoZhqqy1XtecINIdFK6DycgC?=
 =?us-ascii?Q?ARr0pqgZbertpLemhaP4dq+J0yIGmWSK2JluwznQucJpgqVtMJ+7S4XHOiwU?=
 =?us-ascii?Q?jQOA/nFvHJDBgRmaqswI8DStut/S6NO/sTzcihrtO3wzrN/lIaxG5KWpH/4Q?=
 =?us-ascii?Q?gkyOjurnsY1TtxnjTnXKPQKKNO9mp78oyuYy1gC7SsriJIHtbeH+eKvpsmgd?=
 =?us-ascii?Q?EdBStr0YQhSMN3yR+ESyqhh+yxKPiMWE1d5+sz/m4Xln6QgD6MBQkNIfmUZP?=
 =?us-ascii?Q?BPhkm/y76br8nHPUE+v5WjkJSB+ojyLtj9tkentWsZ4+qyi4ThM1uPNKHBh3?=
 =?us-ascii?Q?Eb+S3LXJwsjc678RG3fuK74297kKb7V+lw8zWwBkwWapfBMylce1mriQBlrZ?=
 =?us-ascii?Q?YvMCpxjSj8Yz51Rc9vCOe75Lzo+3u9wdPZG0vzy4Fv/g0iqvg1GBiXT0H4nU?=
 =?us-ascii?Q?NcNXzLtcn/Jg0e6RdvblHEqhghCdUh0PSy7l1Hf5DeHaaycyk/atJYPKaSEi?=
 =?us-ascii?Q?IRLW0hTzS8U33SO0knaxJE3xyqUSbXCKWcB01YNdYk7tsxdrK8In83Ie8wrM?=
 =?us-ascii?Q?FckOtkqEDsI70CiQAqObOteWPlMgLf+SnmiHlLuxGAZ8RXE1xXA+mgiYzqdG?=
 =?us-ascii?Q?KLTO1kpZQqM6YGhv2b6EMlE5L//syRHjeNwf/X/95D/uJ6+seLlYNXwywJmS?=
 =?us-ascii?Q?KcA+zSB14jKOolk5/tzoHGoWZI9Oqa7AkmLpuWBvsducj8AZkz1rkOl2Umz3?=
 =?us-ascii?Q?hOLgf5fJrgshYfmDZD4adVS9fotXEuJ5s+k4WbUCZeC/jaJ6Qe3CZ9wy7BR4?=
 =?us-ascii?Q?mqECnT3zsFJ9292/eUrGHuQ2nJd0x2iQRy/XYThaioSn5l4u5XHHfZDFEcjk?=
 =?us-ascii?Q?AlZKoOKE1Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fffa313c-fdc3-407e-6063-08dec6a9d72e
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 04:36:30.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qwj+ele4h/m2lLMsp6h3mOlLH8vXXxiL2krZxQKcYbW08cvHS0N3eyaFRjz0HPFOEbdGh03EqVclvRE80jUiPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF183341E5B

On Tue, Jun 09, 2026 at 09:21:01PM +0800, Ethan Nelson-Moore wrote:
> A comment in drivers/cxl/port.c refers to CONFIG_PROVE_CXL_LOCKING,
> which was removed in commit 38a34e10768c ("cxl: Drop
> cxl_device_lock()"). That commit switched CXL subsystem locking to
> custom lock classes, which can be validated via the standard
> CONFIG_PROVE_LOCKING option. Update the comment to reflect this.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
>

Hi Ethan,

Thanks for this, LGTM.

Reviewed-by: Richard Cheng <icheng@nvidia.com>


Best regards,
Richard Cheng.
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/cxl/port.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index ada51948d52f..99cf77b6b699 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -18,7 +18,7 @@
>   * firmware) are managed in this drivers context. Each driver instance
>   * is responsible for tearing down the driver context of immediate
>   * descendant ports. The locking for this is validated by
> - * CONFIG_PROVE_CXL_LOCKING.
> + * CONFIG_PROVE_LOCKING.
>   *
>   * The primary service this driver provides is presenting APIs to other
>   * drivers to utilize the decoders, and indicating to userspace (via bind
> -- 
> 2.43.0
> 
> 
