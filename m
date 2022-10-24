Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA5DC67871
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Oct 2022 21:13:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiJXVNY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Oct 2022 17:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiJXVMq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Oct 2022 17:12:46 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DACCBFF0
        for <linux-cxl@vger.kernel.org>; Mon, 24 Oct 2022 12:18:37 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id x13so5640632qvn.6
        for <linux-cxl@vger.kernel.org>; Mon, 24 Oct 2022 12:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KadkR+ifyR7ZI8imrc9fLXlRv6/lWHFSI/suNkMadFk=;
        b=xigwbf27ooYsHnsk6pOd84ANsNckPWHwZUyXGTRV9xqFBY7gIrDce3tuEl968PPkaI
         74nWqslczUnDr0wFTaawTrmJDGA8BINgeGe8sd5kYPsUrWDV2l6kFl3aW8i3hhGNTHT1
         8BelEMlaH0Xm+uf4LCiWp3+e4mg/xA99fP9DBL05NiSDZrk37W1omdkMLZIEmfV3oo+2
         4PyAaLwB7Ic7j+lTONDtRhNkzd09fJ7HcuP8mrQuHbHkbuM1nIVovCnOvNevj6Z8f6ok
         jBim8F/Rga4eeG/cuvCfRzozD8AzShLBRz+S2gx1389Sq5fxombGCuBMIAn3ZvsaRN9b
         2ziQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KadkR+ifyR7ZI8imrc9fLXlRv6/lWHFSI/suNkMadFk=;
        b=PVWiNz0moVNhBpdjnamCh+AQztIRJvdZsC1XPrDQoDo5mxDpTAZd/Gn4/MSHgYv2QC
         msUuWF5wViFR8QZFhORcygjOnHQ05B7G3nJaeY+16N7S1xIvsOX3POikru4bdWvpUhfN
         MbDL0024u7hfnNCeGMAoNDtGpkeqkIsspO1dJxOX51L707bHiBMNwt4apZ6hsT9Z8Gdj
         rSQJHfZ209iYRGcmoPe8PlmZvYM2ROgDgyknQy+9L/37hDjUcvpGcpLJN1fcigtgFkCp
         UnQDsh0KFtocnhS8NKuU+mlmbW596HBYS9WetX+EELayQ9PYjjjQKCe9SEeJSrnRUJSg
         mfLg==
X-Gm-Message-State: ACrzQf09gOf6A03LlqrzkxeGOLoamTu4C10l9p60Jvqg5EM8Rv0Vgi6G
        zuKCFea7za7DHCtayyyUkr64MhcpJmSntQ==
X-Google-Smtp-Source: AMsMyM5OIin9P+YCqZKz8JFQwKQZl/An7ku2SvcX4Kg9Xl+NvB4bB0rMjHmrcQW+F03Ifr2wKVoXpA==
X-Received: by 2002:a05:6214:5191:b0:4bb:6268:422f with SMTP id kl17-20020a056214519100b004bb6268422fmr9694270qvb.99.1666639041169;
        Mon, 24 Oct 2022 12:17:21 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:42f0:6600:103:a056:9abb:d926])
        by smtp.gmail.com with ESMTPSA id r2-20020ac85e82000000b0035ba48c032asm409664qtx.25.2022.10.24.12.17.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Oct 2022 12:17:20 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [External] [RFC PATCH 1/1] cxl/pci: Add support for stand alone
 CXL Switch mailbox CCI
From:   "Viacheslav A.Dubeyko" <viacheslav.dubeyko@bytedance.com>
In-Reply-To: <20221024155322.16661-2-Jonathan.Cameron@huawei.com>
Date:   Mon, 24 Oct 2022 12:17:17 -0700
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linuxarm@huawei.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <E102AAEB-6AC8-45E0-A804-A7CDDB81B5B4@bytedance.com>
References: <20221024155322.16661-1-Jonathan.Cameron@huawei.com>
 <20221024155322.16661-2-Jonathan.Cameron@huawei.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Jonathan,

> On Oct 24, 2022, at 8:53 AM, Jonathan Cameron =
<Jonathan.Cameron@huawei.com> wrote:
>=20
> CXL 3.0 defines a mailbox PCI function independent of any other CXL
> components. The intent is that instances of this mailbox will be found
> as additional PCI functions of upstream CXL switch ports.
>=20
> RFC: Including this directly in cxl/pci.c as a second pci_driver, is a
> bit hacky.  The alternative is to factor out all the common
> infrastructure to a library module shared by the Type 3 PCI driver
> and the Switch CCI driver.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> ---
>=20
> Options to consider:
> 1 - Factor out all the shared code and have a separate module for
>    switch CCI driver. Messy!
> 2 - Is sharing the allow lists between type 3 devices and switch CCI
>    an issue? Not a whole lot of overlap...
> ---
> drivers/cxl/core/Makefile     |   1 +
> drivers/cxl/core/core.h       |   1 +
> drivers/cxl/core/mbox.c       |  20 ++++-
> drivers/cxl/core/port.c       |   4 +
> drivers/cxl/core/switch-cci.c | 142 ++++++++++++++++++++++++++++++++++
> drivers/cxl/cxlmem.h          |   3 +
> drivers/cxl/cxlpci.h          |   3 +
> drivers/cxl/cxlswitch.h       |  17 ++++
> drivers/cxl/pci.c             |  93 +++++++++++++++++++++-
> include/uapi/linux/cxl_mem.h  |   3 +
> 10 files changed, 282 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 79c7257f4107..18275e153437 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -10,4 +10,5 @@ cxl_core-y +=3D memdev.o
> cxl_core-y +=3D mbox.o
> cxl_core-y +=3D pci.o
> cxl_core-y +=3D hdm.o
> +cxl_core-y +=3D switch-cci.o
> cxl_core-$(CONFIG_CXL_REGION) +=3D region.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1d8f87be283f..8ac1a0e2c98f 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -70,5 +70,6 @@ static inline struct cxl_ep *cxl_ep_load(struct =
cxl_port *port,
> int cxl_memdev_init(void);
> void cxl_memdev_exit(void);
> void cxl_mbox_init(void);
> +int cxl_switch_cci_init(void);
>=20
> #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 0c90f13870a4..a4e2cb454094 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -5,6 +5,7 @@
> #include <linux/debugfs.h>
> #include <linux/mutex.h>
> #include <cxlmem.h>
> +#include <cxlpci.h>
> #include <cxl.h>
>=20
> #include "core.h"
> @@ -43,6 +44,8 @@ static bool cxl_raw_allow_all;
>  * 0, and the user passed in 1, it is an error.
>  */
> static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] =
=3D {
> +	CXL_CMD(INFO_STAT_IDENTIFY, 0, 18, 0),
> +	CXL_CMD(GET_BG_CMD_STATUS, 0, 8, 0),

As far as I can see, it is used hexadecimal constants, mostly. So, it =
will be better to use 0x12 instead of 18. However, it will be great, =
from my of view, to use some constant declarations that can explain why =
18 exactly here. Otherwise, maybe, some comments could explain these =
numbers?

> 	CXL_CMD(IDENTIFY, 0, 0x43, CXL_CMD_FLAG_FORCE_ENABLE),
> #ifdef CONFIG_CXL_MEM_RAW_COMMANDS
> 	CXL_CMD(RAW, CXL_VARIABLE_PAYLOAD, CXL_VARIABLE_PAYLOAD, 0),
> @@ -65,6 +68,7 @@ static struct cxl_mem_command =
cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] =3D {
> 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> 	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
> 	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> +	CXL_CMD(IDENTIFY_SWITCH_DEVICE, 0, 0x49, 0),
> };
>=20
> /*
> @@ -526,10 +530,9 @@ static int handle_mailbox_cmd_from_user(struct =
cxl_dev_state *cxlds,
> 	return rc;
> }
>=20
> -int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command =
__user *s)
> +int __cxl_send_cmd(struct cxl_dev_state *cxlds, struct device *dev,
> +		   struct cxl_send_command __user *s)
> {
> -	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
> -	struct device *dev =3D &cxlmd->dev;
> 	struct cxl_send_command send;
> 	struct cxl_mbox_cmd mbox_cmd;
> 	int rc;
> @@ -539,7 +542,7 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct =
cxl_send_command __user *s)
> 	if (copy_from_user(&send, s, sizeof(send)))
> 		return -EFAULT;
>=20
> -	rc =3D cxl_validate_cmd_from_user(&mbox_cmd, cxlmd->cxlds, =
&send);
> +	rc =3D cxl_validate_cmd_from_user(&mbox_cmd, cxlds, &send);
> 	if (rc)
> 		return rc;
>=20
> @@ -553,6 +556,15 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct =
cxl_send_command __user *s)
>=20
> 	return 0;
> }
> +EXPORT_SYMBOL_GPL(__cxl_send_cmd);
> +

I am guessing=E2=80=A6 If cxl_send_cmd is introduces already, then do we =
really need to keep __cxl_send_cmd as not static? Any special use-cases =
for using __cxl_send_cmd?

> +int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command =
__user *s)
> +{
> +	struct cxl_dev_state *cxlds =3D cxlmd->cxlds;
> +	struct device *dev =3D &cxlmd->dev;
> +
> +	return __cxl_send_cmd(cxlds, dev, s);
> +}
>=20
> static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 =
size, u8 *out)
> {
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index bffde862de0b..3b2e93bc4684 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1859,6 +1859,10 @@ static __init int cxl_core_init(void)
> 	if (rc)
> 		return rc;
>=20
> +	rc =3D cxl_switch_cci_init();
> +	if (rc)
> +		return rc;
> +
> 	cxl_bus_wq =3D alloc_ordered_workqueue("cxl_port", 0);
> 	if (!cxl_bus_wq) {
> 		rc =3D -ENOMEM;
> diff --git a/drivers/cxl/core/switch-cci.c =
b/drivers/cxl/core/switch-cci.c
> new file mode 100644
> index 000000000000..1ce51cc07cba
> --- /dev/null
> +++ b/drivers/cxl/core/switch-cci.c
> @@ -0,0 +1,142 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <cxlswitch.h>
> +#include "cxlmem.h" /* For now to get the cxl_device_state */
> +#include "cxlpci.h"
> +#include "core.h"
> +
> +
> +static int cxl_sw_major;
> +static DEFINE_IDA(cxl_swdev_ida);
> +static DECLARE_RWSEM(cxl_swdev_rwsem);

I am not sure how good and safe could be static semaphore. Currently, I =
cannot share any potential troubles with it. But lifetime of this =
semaphore will be the same as module itself. So, it sounds that we will =
take memory even if functionality of this module never will be used. And =
I assume that we pollute the global namespace with the name of this =
semaphore.

> +
> +static inline struct cxl_swdev *to_cxl_swdev(struct device *dev)
> +{
> +	return container_of(dev, struct cxl_swdev, dev);
> +}
> +
> +static char *cxl_swdev_devnode(struct device *dev, umode_t *mode, =
kuid_t *uid,
> +			kgid_t *gid)
> +{
> +	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
> +}
> +
> +static void cxl_swdev_release(struct device *dev)
> +{
> +	struct cxl_swdev *cxlswd =3D to_cxl_swdev(dev);
> +
> +	ida_free(&cxl_swdev_ida, cxlswd->id);
> +	kfree(cxlswd);
> +}

It looks slightly confusing for me to see cxl_swdev_release() without =
allocate pair around. Maybe, it makes sense to keep allocate/release =
pair at the same place? Otherwise, it needs to search allocate method to =
understand the release logic.

> +
> +static const struct device_type cxl_swdev_type =3D {
> +	.name =3D "cxl_swdev",
> +	.release =3D cxl_swdev_release,
> +	.devnode =3D cxl_swdev_devnode,
> +};
> +
> +static long __cxl_swdev_ioctl(struct cxl_swdev *cxlswd, unsigned int =
cmd,
> +			       unsigned long arg)
> +{
> +	switch (cmd) {
> +	case CXL_MEM_SEND_COMMAND:
> +		return __cxl_send_cmd(cxlswd->cxlds, &cxlswd->dev, (void =
__user *)arg);
> +	default:
> +		return -ENOTTY;
> +	}
> +}
> +
> +static long cxl_swdev_ioctl(struct file *file, unsigned int cmd,
> +			    unsigned long arg)
> +{
> +	struct cxl_swdev *cxlswd =3D file->private_data;
> +	int rc =3D -ENXIO;
> +
> +	down_read(&cxl_swdev_rwsem);
> +	if (cxlswd->cxlds)
> +		rc =3D __cxl_swdev_ioctl(cxlswd, cmd, arg);
> +	up_read(&cxl_swdev_rwsem);
> +

Can we rearrange the logic?

if (cxlswd->cxlds) {
    down_read(&cxl_swdev_rwsem);
    rc =3D __cxl_swdev_ioctl(cxlswd, cmd, arg);
   up_read(&cxl_swdev_rwsem);
}

Does cxl_swdev_rwsem protect the cxlswd->cxlds pointer?


> +	return rc;
> +}
> +
> +static int cxl_swdev_open(struct inode *inode, struct file *file)
> +{
> +	struct cxl_memdev *cxlswd =3D
> +		container_of(inode->i_cdev, typeof(*cxlswd), cdev);
> +
> +	get_device(&cxlswd->dev);
> +	file->private_data =3D cxlswd;
> +
> +	return 0;
> +}
> +
> +static int cxl_swdev_release_file(struct inode *inode, struct file =
*file)
> +{
> +	struct cxl_swdev *cxlswd =3D
> +		container_of(inode->i_cdev, typeof(*cxlswd), cdev);
> +
> +	put_device(&cxlswd->dev);
> +
> +	return 0;
> +}
> +
> +static const struct file_operations cxl_swdev_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.unlocked_ioctl =3D cxl_swdev_ioctl,
> +	.open =3D cxl_swdev_open,
> +	.release =3D cxl_swdev_release_file,
> +	.compat_ioctl =3D compat_ptr_ioctl,
> +	.llseek =3D noop_llseek,
> +};
> +
> +struct cxl_swdev *cxl_swdev_alloc(struct cxl_dev_state *cxlds)
> +{
> +	struct cxl_swdev *cxlswd;
> +	struct device *dev;
> +	struct cdev *cdev;
> +	int rc;
> +
> +	cxlswd =3D kzalloc(sizeof(*cxlswd), GFP_KERNEL);
> +	if (!cxlswd)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rc =3D ida_alloc_range(&cxl_swdev_ida, 0, 10, GFP_KERNEL);
> +	if (rc < 0) {
> +		kfree(cxlswd);

Maybe, it makes sense to combine all free logic for failure case in one =
place? I believe it could make the logic more clean and method could be =
easy to modify in the future without introduction of new tricky bugs.

> +		return ERR_PTR(rc);
> +	}
> +
> +	cxlswd->id =3D rc;
> +	cxlswd->cxlds =3D cxlds;
> +	dev =3D &cxlswd->dev;
> +	device_initialize(dev);
> +	dev->parent =3D cxlds->dev;
> +	dev->bus =3D &cxl_bus_type;
> +	dev->devt =3D MKDEV(cxl_sw_major, cxlswd->id);
> +	dev->type =3D &cxl_swdev_type;
> +	device_set_pm_not_required(dev);
> +	cdev =3D &cxlswd->cdev;
> +	cdev_init(cdev, &cxl_swdev_fops);
> +	rc =3D dev_set_name(dev, "swcci%d", cxlswd->id);
> +	if (rc) {
> +		put_device(dev);
> +		ida_free(&cxl_swdev_ida, cxlswd->id);

Ditto.

> +		return ERR_PTR(rc);
> +	}
> +
> +	return cxlswd;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_swdev_alloc, CXL);
> +
> +__init int cxl_switch_cci_init(void)
> +{
> +	dev_t devt;
> +	int rc;
> +
> +	rc =3D alloc_chrdev_region(&devt, 0, 10, "cxlsw");
> +	if (rc)
> +		return rc;
> +	cxl_sw_major =3D MAJOR(devt);
> +
> +	return 0;
> +}
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 88e3a8e54b6a..ef9c0c347daf 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -252,6 +252,8 @@ struct cxl_dev_state {
>=20
> enum cxl_opcode {
> 	CXL_MBOX_OP_INVALID		=3D 0x0000,
> +	CXL_MBOX_OP_INFO_STAT_IDENTIFY	=3D 0x0001,
> +	CXL_MBOX_OP_GET_BG_CMD_STATUS	=3D 0x0002,

I know that people likes to hardcode constants. :) But it could be hard =
to follow these constants. Maybe, we need to introduce some comments?

> 	CXL_MBOX_OP_RAW			=3D CXL_MBOX_OP_INVALID,
> 	CXL_MBOX_OP_GET_FW_INFO		=3D 0x0200,
> 	CXL_MBOX_OP_ACTIVATE_FW		=3D 0x0202,
> @@ -273,6 +275,7 @@ enum cxl_opcode {
> 	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	=3D 0x4303,
> 	CXL_MBOX_OP_SCAN_MEDIA		=3D 0x4304,
> 	CXL_MBOX_OP_GET_SCAN_MEDIA	=3D 0x4305,
> +	CXL_MBOX_OP_IDENTIFY_SWITCH_DEVICE	=3D 0x5100,
> 	CXL_MBOX_OP_MAX			=3D 0x10000
> };
>=20
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index eec597dbe763..7f53b601ad7c 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -75,4 +75,7 @@ int devm_cxl_port_enumerate_dports(struct cxl_port =
*port);
> struct cxl_dev_state;
> int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm =
*cxlhdm);
> void read_cdat_data(struct cxl_port *port);
> +struct cxl_send_command;
> +int __cxl_send_cmd(struct cxl_dev_state *cxlds, struct device *dev,
> +		   struct cxl_send_command __user *s);
> #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/cxlswitch.h b/drivers/cxl/cxlswitch.h
> new file mode 100644
> index 000000000000..4d1689db653c
> --- /dev/null
> +++ b/drivers/cxl/cxlswitch.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef CXLSWITCH_H
> +#define CXLSWITCH_H
> +#include <linux/cdev.h>
> +#include <linux/device.h>
> +#include "cxl.h"
> +
> +struct cxl_dev_state;
> +struct cxl_swdev {
> +	struct device dev;
> +	struct cdev cdev;
> +	struct cxl_dev_state *cxlds;
> +	int id;
> +};
> +
> +struct cxl_swdev *cxl_swdev_alloc(struct cxl_dev_state *cxlds);

Do we declare alloc but not the free/release? Why so?

> +#endif
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index faeb5d9d7a7a..a7aec6247e86 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -12,6 +12,7 @@
> #include <linux/io.h>
> #include "cxlmem.h"
> #include "cxlpci.h"
> +#include "cxlswitch.h"
> #include "cxl.h"
>=20
> /**
> @@ -520,6 +521,96 @@ static struct pci_driver cxl_pci_driver =3D {
> 	},
> };
>=20
> +static int cxl_swmbcci_probe(struct pci_dev *pdev, const struct =
pci_device_id *id)
> +{
> +	struct cxl_dev_state *cxlds;
> +	struct cxl_register_map map;
> +	struct cxl_swdev *cxlswd;
> +	int rc;
> +
> +	rc =3D pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
> +
> +	cxlds =3D cxl_dev_state_create(&pdev->dev);
> +	if (IS_ERR(cxlds))
> +		return PTR_ERR(cxlds);
> +
> +	rc =3D cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D cxl_map_regs(cxlds, &map);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D cxl_pci_setup_mailbox(cxlds);
> +	if (rc)
> +		return rc;
> +
> +	cxlswd =3D cxl_swdev_alloc(cxlds);
> +	if (IS_ERR(cxlswd))
> +		return PTR_ERR(cxlswd);
> +
> +	pci_set_drvdata(pdev, cxlswd);
> +
> +	rc =3D cxl_enumerate_cmds(cxlds);
> +	if (rc)
> +		goto error_put_device;
> +
> +	rc =3D cdev_device_add(&cxlswd->cdev, &cxlswd->dev);
> +	if (rc)
> +		goto error_put_device;
> +
> +	return 0;
> +
> +error_put_device:

If we failed, then no cxlswd release. So, when this memory is released =
then? Maybe, I don=E2=80=99t follow the code logic here.

> +	put_device(&cxlswd->dev);
> +	return rc;
> +}
> +
> +static void cxl_swbmcci_remove(struct pci_dev *pdev)
> +{
> +	struct cxl_swdev *cxlswd =3D pci_get_drvdata(pdev);
> +	struct device *dev =3D &cxlswd->dev;
> +
> +	cdev_device_del(&cxlswd->cdev, dev);
> +	put_device(&cxlswd->dev);
> +}
> +
> +static const struct pci_device_id cxl_swmbcci_pci_tbl[] =3D {
> +	{ PCI_DEVICE_CLASS((0x0c0b << 8 | 0), ~0)},

I believe (0x0c0b << 8 | 0) could be represented by some define, for =
example. Also, it=E2=80=99s hard to follow what magic 0x0c0b represent. =
And why 8 was used for shift operation. Maybe, some constant or comments =
make sense to add?

Thanks,
Slava.

> +	{}
> +};
> +
> +static struct pci_driver cxl_swmbcci_driver =3D {
> +	.name =3D "cxl_swmbcci",
> +	.id_table =3D cxl_swmbcci_pci_tbl,
> +	.probe =3D cxl_swmbcci_probe,
> +	.remove =3D cxl_swbmcci_remove,
> +};
> +
> +static int __init cxl_pci_init(void)
> +{
> +	int rc;
> +
> +	rc =3D pci_register_driver(&cxl_pci_driver);
> +	if (rc)
> +		return rc;
> +
> +	rc =3D pci_register_driver(&cxl_swmbcci_driver);
> +	if (rc) {
> +		pci_unregister_driver(&cxl_pci_driver);
> +		return rc;
> +	}
> +	return 0;
> +}
> +module_init(cxl_pci_init);
> +static void __exit cxl_pci_exit(void)
> +{
> +	pci_unregister_driver(&cxl_swmbcci_driver);
> +	pci_unregister_driver(&cxl_pci_driver);
> +}
> +module_exit(cxl_pci_exit);
> MODULE_LICENSE("GPL v2");
> -module_pci_driver(cxl_pci_driver);
> MODULE_IMPORT_NS(CXL);
> diff --git a/include/uapi/linux/cxl_mem.h =
b/include/uapi/linux/cxl_mem.h
> index c71021a2a9ed..ea03a289e56f 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -41,6 +41,9 @@
> 	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),        =
 \
> 	___C(SCAN_MEDIA, "Scan Media"),                                  =
 \
> 	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                  =
 \
> +	___C(INFO_STAT_IDENTIFY, "Get Information"),			 =
 \
> +	___C(GET_BG_CMD_STATUS, "Background Command Status"),            =
 \
> +	___C(IDENTIFY_SWITCH_DEVICE, "Identify Switch Device"),          =
 \
> 	___C(MAX, "invalid / last command")
>=20
> #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> --=20
> 2.37.2
>=20

