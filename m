Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D013C433F5
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Dec 2021 03:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354674AbhLDD0o (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Dec 2021 22:26:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbhLDD0o (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Dec 2021 22:26:44 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75766C061751
        for <linux-cxl@vger.kernel.org>; Fri,  3 Dec 2021 19:23:19 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso4100411pjb.0
        for <linux-cxl@vger.kernel.org>; Fri, 03 Dec 2021 19:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7Fp3ZoEculaRsV+LP87CPsRqOalwQ/ripZwMOk8Zac=;
        b=FYv/oemWoYKj3H48PqCUeB1rjPL5TFgDUFkIIDt2jpR+n073bnoqY4NAwOa+eTXcJ+
         mMvQ0unYET1/uh7fdvTf0LdJ6NMhH9FTblK2nnMFZz8mo4MHXkQOtNiblb7zvPJEPeo7
         oQEQjL5a2RUh/3HcK0JL7aG5hDQiTfrG9HBRMa1geqBwCQjNb6qf+h7IPR9BA6IMOJY7
         M5J+EHVnlEPG2NePxSaQlN43yXFVTWVfqM4BYYbp0gwLcxJhJvDUc0BAUEB/wx7exCry
         PN5MtZOx/SGqUS4NEWG/33FP921VjJDRCl28bNS1LU+vX21tZa25EAhhXAZtYiGJ6Fsr
         om0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7Fp3ZoEculaRsV+LP87CPsRqOalwQ/ripZwMOk8Zac=;
        b=kMpddA3v7RcPNKr2fonEYMp3J50QC44dsfhGbT8u/ZLFthURoOJZpJveZf0NVPQt/3
         ceCJhmUkeTPb3EGKybD/o3ULe5K2eASZlmCBMYPx2JeincyY7GvMbsreg1dlBiuXJfwh
         99hEVo5FR3eCQgoSsCFw7ehi9nLIJrNBp5qxxU5Abq+QF7lMJFtzX7lkSKujJJB0Iq0e
         YlffEvjkW/zGernLQdssFP3llD0DQqMk7hW9iUECTe9Ej3YxL7iCmYTN+KJZj//BLyht
         u4CV6FHhmxZn+s+/WdbxyDAdJtXeThZ7dQMzkIcvT3gZrX9fbDgzGFlmuN6x74oOnhGE
         ri1A==
X-Gm-Message-State: AOAM533HhIBgXhclvqeVx6yebUhTzONjGcut+yYMyk7AyAt1JmRPzhK/
        4k0XbfuNDLijmIp9JxHQAzdI2crJbVsPZbImCY7b9Q==
X-Google-Smtp-Source: ABdhPJx0r0DeAmoCht/rbzp4vMVr2aIR6H0IITHqY/xUtatT8U0xpk11HaKH8PAzt3BvHLKdXD1BologqB0pFrhBIM4=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr18870078pjb.93.1638588198842;
 Fri, 03 Dec 2021 19:23:18 -0800 (PST)
MIME-Version: 1.0
References: <163855973642.1338601.12855868083437118567.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163855974678.1338601.8865645356209268622.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20211204015306.464jmm2fkn6ihvbk@intel.com>
In-Reply-To: <20211204015306.464jmm2fkn6ihvbk@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 3 Dec 2021 19:23:10 -0800
Message-ID: <CAPcyv4ibUHf_oCGenLZCArXd65yzyiDmbYSPfY=xteQwFzCfbw@mail.gmail.com>
Subject: Re: [PATCH 2/2] cxl/pci: Defer mailbox status checks to command timeouts
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Schofield, Alison" <alison.schofield@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Dec 3, 2021 at 5:53 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> On 21-12-03 11:29:06, Dan Williams wrote:
> > Device status can change without warning at any point in time. This
> > effectively means that no amount of status checking before a command is
> > submitted can guarantee that the device is not in an error condition
> > when the command is later submitted. The clearest signal that a device
> > is not able to process commands is if it fails to process commands.
> >
> > With the above understanding in hand, update cxl_pci_setup_mailbox() to
> > validate the readiness of the mailbox once at the beginning of time, and
> > then use timeouts and busy sequencing errors as the only occasions to
> > report status.
> >
> > Just as before, unless and until the driver gains a reset recovery path,
> > doorbell clearing failures by the device are fatal to mailbox
> > operations.
> >
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/pci.c |  138 ++++++++++++++---------------------------------------
> >  1 file changed, 36 insertions(+), 102 deletions(-)
> >
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 519795432708..36f80437a11a 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -72,14 +72,16 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
> >       return 0;
> >  }
> >
> > -static void cxl_pci_mbox_timeout(struct cxl_dev_state *cxlds,
> > -                              struct cxl_mbox_cmd *mbox_cmd)
> > -{
> > -     struct device *dev = cxlds->dev;
> > +#define report_status(dev, status, msg)                                        \
> > +     dev_err_ratelimited(dev, msg ", device state %s%s\n",                  \
> > +                         status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
> > +                         status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
> >
> > -     dev_dbg(dev, "Mailbox command (opcode: %#x size: %zub) timed out\n",
> > -             mbox_cmd->opcode, mbox_cmd->size_in);
> > -}
> > +#define report_cmd_status(dev, cmd, status, msg)                               \
> > +     dev_err_ratelimited(dev, msg " (opcode: %#x), device state %s%s\n",    \
> > +                         (cmd)->opcode,                                     \
> > +                         status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
> > +                         status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
> >
> >  /**
> >   * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
> > @@ -133,7 +135,11 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
> >
> >       /* #1 */
> >       if (cxl_doorbell_busy(cxlds)) {
> > -             dev_err_ratelimited(dev, "Mailbox re-busy after acquiring\n");
> > +             u64 md_status =
> > +                     readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> > +
> > +             report_cmd_status(cxlds->dev, mbox_cmd, md_status,
> > +                               "mailbox queue busy");
> >               return -EBUSY;
> >       }
> >
> > @@ -159,7 +165,10 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
> >       /* #5 */
> >       rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
> >       if (rc == -ETIMEDOUT) {
> > -             cxl_pci_mbox_timeout(cxlds, mbox_cmd);
> > +             u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> > +
> > +             report_cmd_status(cxlds->dev, mbox_cmd, md_status,
> > +                               "mailbox timeout");
> >               return rc;
> >       }
> >
> > @@ -197,98 +206,13 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
> >       return 0;
> >  }
> >
> > -/**
> > - * cxl_pci_mbox_get() - Acquire exclusive access to the mailbox.
> > - * @cxlds: The device state to gain access to.
> > - *
> > - * Context: Any context. Takes the mbox_mutex.
> > - * Return: 0 if exclusive access was acquired.
> > - */
> > -static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
> > -{
> > -     struct device *dev = cxlds->dev;
> > -     u64 md_status;
> > -     int rc;
> > -
> > -     mutex_lock_io(&cxlds->mbox_mutex);
> > -
> > -     /*
> > -      * XXX: There is some amount of ambiguity in the 2.0 version of the spec
> > -      * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
> > -      * bit is to allow firmware running on the device to notify the driver
> > -      * that it's ready to receive commands. It is unclear if the bit needs
> > -      * to be read for each transaction mailbox, ie. the firmware can switch
> > -      * it on and off as needed. Second, there is no defined timeout for
> > -      * mailbox ready, like there is for the doorbell interface.
> > -      *
> > -      * Assumptions:
> > -      * 1. The firmware might toggle the Mailbox Interface Ready bit, check
> > -      *    it for every command.
> > -      *
> > -      * 2. If the doorbell is clear, the firmware should have first set the
> > -      *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
> > -      *    to be ready is sufficient.
> > -      */
> > -     rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
> > -     if (rc) {
> > -             dev_warn(dev, "Mailbox interface not ready\n");
> > -             goto out;
> > -     }
> > -
> > -     md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
> > -     if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
> > -             dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
> > -             rc = -EBUSY;
> > -             goto out;
> > -     }
> > -
> > -     /*
> > -      * Hardware shouldn't allow a ready status but also have failure bits
> > -      * set. Spit out an error, this should be a bug report
> > -      */
> > -     rc = -EFAULT;
> > -     if (md_status & CXLMDEV_DEV_FATAL) {
> > -             dev_err(dev, "mbox: reported ready, but fatal\n");
> > -             goto out;
> > -     }
> > -     if (md_status & CXLMDEV_FW_HALT) {
> > -             dev_err(dev, "mbox: reported ready, but halted\n");
> > -             goto out;
> > -     }
> > -     if (CXLMDEV_RESET_NEEDED(md_status)) {
> > -             dev_err(dev, "mbox: reported ready, but reset needed\n");
> > -             goto out;
> > -     }
> > -
> > -     /* with lock held */
> > -     return 0;
> > -
> > -out:
> > -     mutex_unlock(&cxlds->mbox_mutex);
> > -     return rc;
> > -}
> > -
> > -/**
> > - * cxl_pci_mbox_put() - Release exclusive access to the mailbox.
> > - * @cxlds: The device state to communicate with.
> > - *
> > - * Context: Any context. Expects mbox_mutex to be held.
> > - */
> > -static void cxl_pci_mbox_put(struct cxl_dev_state *cxlds)
> > -{
> > -     mutex_unlock(&cxlds->mbox_mutex);
> > -}
> > -
>
> I appreciate the goal of reducing the set of functions to initiate a mailbox
> command. The idea behind get/put was that it might be desirable to issues
> multiple commands in a sequence. I'll agree we have no such usage today and so
> we can bring this back as needed. I just wanted to justify the intent :-)
>

If it came back, why would it be anything more than an open coded
acquisition of the mutex?

> >  static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> >  {
> >       int rc;
> >
> > -     rc = cxl_pci_mbox_get(cxlds);
> > -     if (rc)
> > -             return rc;
> > -
> > +     mutex_lock_io(&cxlds->mbox_mutex);
> >       rc = __cxl_pci_mbox_send_cmd(cxlds, cmd);
> > -     cxl_pci_mbox_put(cxlds);
> > +     mutex_unlock(&cxlds->mbox_mutex);
> >
> >       return rc;
> >  }
> > @@ -309,12 +233,22 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
> >       } while (!time_after(jiffies, timeout));
> >
> >       if (!(md_status & CXLMDEV_MBOX_IF_READY)) {
> > -             dev_err(cxlds->dev,
> > -                     "timeout awaiting mailbox ready, device state:%s%s\n",
> > -                     md_status & CXLMDEV_DEV_FATAL ? " fatal" : "",
> > -                     md_status & CXLMDEV_FW_HALT ? " firmware-halt" : "");
> > -             return -EIO;
> > -        }
> > +             report_status(cxlds->dev, md_status,
> > +                           "timeout awaiting mailbox ready");
> > +             return -ETIMEDOUT;
> > +     }
> > +
> > +     /*
> > +      * A command may be in flight from a previous driver instance,
> > +      * think kexec, do one doorbell wait so that
> > +      * __cxl_pci_mbox_send_cmd() can assume that it is the only
> > +      * source for future doorbell busy events.
> > +      */
> > +     if (cxl_pci_mbox_wait_for_doorbell(cxlds) != 0) {
> > +             report_status(cxlds->dev, md_status,
> > +                           "timeout awaiting mailbox idle");
> > +             return -ETIMEDOUT;
> > +     }
>
> Can kexec happen while the mailbox mutex is held? That's really scary. If it
> can't I believe this is unnecessary.

Sure. kexec requires no coordination from the kernel being replaced.
It could be triggered by a crash on another CPU.

There is even a possibility userspace driver or BIOS could have been
using the mailbox before the driver was loaded, who knows. cxl_pci
just needs a reasonable assurance that any doorbell status it sees
going forward is either from a command it submitted or an error.
